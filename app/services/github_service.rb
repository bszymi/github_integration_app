# frozen_string_literal: true

class GithubService
  attr_reader :username

  def initialize(username)
    @username = username
  end

  def fetch_user_details(cursor = nil)
    # Implement the logic to perform the GraphQL query here
    # Return the parsed JSON response
  end

  private

  def perform_query(cursor)
    # Use HTTParty or similar gem to perform the GraphQL query
    # Handle pagination
  end
end
