# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubUserDataUpdater do
  describe '#update_user_data' do
    let(:username) { 'sample_username' }
    let(:github_service_double) { instance_double(GithubService) }
    let(:user_data) { github_api_user_data }

    before do
      allow(GithubService).to receive(:new).with(username).and_return(github_service_double)
      allow(github_service_double).to receive(:fetch_user_details).and_return(user_data)
      GithubUserDataUpdater.new(username).update_user_data
    end

    it 'creates or updates user and repository records' do
      user = User.find_by(username:)
      expect(user).not_to be_nil
      expect(User.find_by(username:)).not_to be_nil
      expect(Repository.where(user_id: user.id)).not_to be_empty

      # Test if specific repositories are added
      repo1 = user.repositories.find_by(name: 'Repo1')
      expect(repo1).not_to be_nil
      expect(repo1.star_count).to eq(10)

      # Test if the language data for Repo1 is correct
      expect(repo1.language_usages.count).to eq(2)
      expect(repo1.language_usages.find_by(language_name: 'Ruby').byte_size).to eq(12_000)
      expect(repo1.language_usages.find_by(language_name: 'JavaScript').byte_size).to eq(8000)

      # Repeat similar tests for Repo2
      repo2 = user.repositories.find_by(name: 'Repo2')
      expect(repo2).not_to be_nil
      expect(repo2.star_count).to eq(8)

      # Test if the language data for Repo2 is correct
      expect(repo2.language_usages.count).to eq(1)
      expect(repo2.language_usages.find_by(language_name: 'Python').byte_size).to eq(15_000)
    end
  end
end
