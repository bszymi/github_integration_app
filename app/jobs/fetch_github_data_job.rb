# frozen_string_literal: true

class FetchGithubDataJob < ApplicationJob
  queue_as :default

  def perform
    sorted_users = UserSorterAndRearranger.sort_and_rearrange_users
    sorted_users.each do |user|
      GithubDataRefreshJob.perform_later(user.id)
    end
  end
end
