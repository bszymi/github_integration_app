# frozen_string_literal: true

class GithubUserDataUpdater
  def initialize(username)
    @username = username
  end

  def update_user_data
    github_service = GithubService.new(@username)
    user_data = github_service.fetch_user_details

    user = User.find_or_initialize_by(username: @username)
    update_user_repositories(user, user_data[:user][:repositories])
    user.save!
  end

  private

  # TODO: handle deleted repositories
  def update_user_repositories(user, repositories_data)
    repositories_data.each do |repo_data|
      repo_attrs = repo_data[:node]
      repo = user.repositories.find_or_initialize_by(name: repo_attrs[:name])
      repo.star_count = repo_attrs[:stargazers][:totalCount]
      repo.save!
      update_language_usage(repo, repo_attrs[:languages][:edges])
    end
  end

  def update_language_usage(repository, languages_data)
    current_languages = repository.language_usages.index_by(&:language_name)
    updated_languages = languages_data.map { |ld| ld[:node][:name] }

    languages_data.each do |language_data|
      update_or_create_language(repository, language_data)
    end

    delete_removed_languages(current_languages, updated_languages)
  end

  def update_or_create_language(repository, language_data)
    language_name = language_data[:node][:name]
    byte_size = language_data[:size]

    language_usage = repository.language_usages.find_or_initialize_by(language_name:)
    language_usage.update(byte_size:)
  end

  def delete_removed_languages(current_languages, updated_languages)
    current_languages.each do |language_name, language_usage|
      language_usage.destroy unless updated_languages.include?(language_name)
    end
  end

end
