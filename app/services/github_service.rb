# frozen_string_literal: true

class GithubService
  include HTTParty
  base_uri 'https://api.github.com/'

  def initialize(username)
    @username = username
  end

  def fetch_user_details(cursor = nil)
    result = { user: { repositories: [] } }
    loop do
      response = perform_query(cursor)
      break unless response.success?

      repositories = response.dig('data', 'user', 'repositories')
      result[:user][:repositories].concat(repositories['edges'])

      break unless repositories['pageInfo']['hasNextPage']

      cursor = repositories['pageInfo']['endCursor']
    end
    result
  end

  private

  def perform_query(cursor)
    query = {
      query: graphql_query,
      variables: { username: @username, cursor: }.compact
    }
    self.class.post('/graphql', body: query.to_json, headers: request_headers)
  end

  def graphql_query
    <<~GRAPHQL
      query($username: String!, $cursor: String) {
        user(login: $username) {
          repositories(first: 100, after: $cursor, orderBy: {field: STARGAZERS, direction: DESC}) {
            totalCount
            edges {
              cursor
              node {
                name
                stargazers {
                  totalCount
                }
                languages(first: 5, orderBy: {field: SIZE, direction: DESC}) {
                  edges {
                    size
                    node {
                      name
                    }
                  }
                }
              }
            }
            pageInfo {
              hasNextPage
              endCursor
            }
          }
        }
      }
    GRAPHQL
  end

  def request_headers
    {
      'Authorization' => "Bearer #{ENV['GITHUB_TOKEN']}",
      'Content-Type' => 'application/json'
    }
  end
end
