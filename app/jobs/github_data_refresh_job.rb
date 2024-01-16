# frozen_string_literal: true

class GithubDataRefreshJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    GithubUserDataUpdater.new(user.username).update_user_data
  end
end
