require 'rails_helper'

RSpec.describe GithubService do
  describe '#fetch_user_details' do
    let(:username) { 'sample_username' }

    it 'successfully retrieves user repository data' do
      service = GithubService.new(username)
      result = service.fetch_user_details

      expect(result).to be_a Hash
      expect(result[:user]).to have_key(:repositories)
    end
  end
end
