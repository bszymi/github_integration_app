# frozen_string_literal: true

def github_api_user_data
  {
    user: {
      repositories: [
        {
          node: {
            name: 'Repo1',
            stargazers: {
              totalCount: 10
            },
            languages: {
              edges: [
                {
                  size: 12_000,
                  node: {
                    name: 'Ruby'
                  }
                },
                {
                  size: 8000,
                  node: {
                    name: 'JavaScript'
                  }
                }
              ]
            }
          }
        },
        {
          node: {
            name: 'Repo2',
            stargazers: {
              totalCount: 8
            },
            languages: {
              edges: [
                {
                  size: 15_000,
                  node: {
                    name: 'Python'
                  }
                }
              ]
            }
          }
        }
        # ... more repositories if needed ...
      ]
    }
  }
end
