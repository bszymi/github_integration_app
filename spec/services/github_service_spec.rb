require 'rails_helper'

RSpec.describe GithubService do
  describe '#fetch_user_details' do
    let(:username) { 'sample_username' }
    let(:github_response) do
      {
        data: {
          user: {
            repositories: {
              totalCount: 2,
              edges: [
                # ... mocked repository data ...
              ],
              pageInfo: {
                hasNextPage: false,
                endCursor: nil
              }
            }
          }
        }
      }.to_json
    end

    before do
      stub_request(:post, "https://api.github.com/graphql")
        .with(
          body: hash_including(query: instance_of(String)),
          headers: {
            'Authorization' => "Bearer #{ENV['GITHUB_TOKEN']}",
            'Content-Type' => 'application/json'
          }
        )
        .to_return(status: 200, body: github_response, headers: { 'Content-Type' => 'application/json' })
    end

    it 'successfully retrieves user repository data' do
      service = GithubService.new(username)
      result = service.fetch_user_details

      expect(result).to be_a Hash
      expect(result[:user]).to have_key(:repositories)
      expect(result[:user][:repositories]).to be_an Array
    end
  end
end
