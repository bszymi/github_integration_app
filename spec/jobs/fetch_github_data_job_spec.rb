# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchGithubDataJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    let(:users) { create_list(:user, 3) }

    before do
      allow(UserSorterAndRearranger).to receive(:sort_and_rearrange_users).and_return(users)
    end

    it 'enqueues a GithubDataRefreshJob for each sorted user' do
      expect { described_class.perform_now }.to change { enqueued_jobs.size }.by(users.size)

      users.each do |user|
        expect(GithubDataRefreshJob).to have_been_enqueued.with(user.id)
      end
    end
  end
end
