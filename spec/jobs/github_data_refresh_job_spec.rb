# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubDataRefreshJob, type: :job do
  include ActiveJob::TestHelper

  let(:user) { create(:user, username: 'testuser') }

  describe '#perform' do
    it 'enqueues and performs the job to update user data' do
      expect { GithubDataRefreshJob.perform_later(user.id) }
        .to have_enqueued_job.with(user.id)

      updater = instance_double(GithubUserDataUpdater)
      allow(GithubUserDataUpdater).to receive(:new).with(user.username).and_return(updater)
      allow(updater).to receive(:update_user_data)

      perform_enqueued_jobs { GithubDataRefreshJob.perform_later(user.id) }

      expect(GithubUserDataUpdater).to have_received(:new).with(user.username)
      expect(updater).to have_received(:update_user_data)
    end
  end
end
