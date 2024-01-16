
# Ruby on Rails GitHub Integration App

## Introduction

This Ruby on Rails application interfaces with GitHub's API to retrieve and process user data, leveraging background jobs to optimize and schedule data refresh tasks. The application is built with Rails 7.1.2 and Ruby 3.2.2, focusing on backend functionality and efficiency.

## Features

- Integration with GitHub's public API.
- Background job scheduling for periodic data refresh using Sidekiq.
- Efficient data processing with a prioritization system based on user activity.

## Prerequisites

Before setting up the project, ensure you have the following installed:
- Ruby 3.2.2
- Rails 7.1.2
- PostgreSQL (Database)
- Redis (For Sidekiq)

## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/bszymi/github_integration_app.git
   cd github_integration_app
   ```

2. **Install Dependencies:**

   ```bash
   bundle install
   ```

3. **Database Setup:**

   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Environment Variables:**

   Set up the necessary environment variables:

   ```
   GITHUB_TOKEN=your_github_personal_access_token
   ```

## Running the Application

1. **Start the Rails Server:**

   ```bash
   rails server
   ```

2. **Start Sidekiq for Background Jobs:**

   In a separate terminal window, run:

   ```bash
   sidekiq
   ```

3. **Accessing the Application:**

   Open `http://localhost:3000` in your web browser.

## Running Tests

Run the test suite to ensure everything is functioning as expected:

```bash
rspec
```

## Usage

### Adding a New User

To add a new user to the system (and thereby schedule data fetching from GitHub), send a POST request to the `/users` endpoint with the username:

```http
POST /users
Content-Type: application/json

{
  "username": "github_username"
}
```

This will add the user to the database and schedule background jobs for fetching and updating their GitHub data.

### API Endpoints

Detail any other API endpoints here if available.

## License

This project is licensed under the [MIT License].

## Acknowledgments

- [GitHub API](https://docs.github.com/en/rest)
- [Sidekiq](https://sidekiq.org/)
- [Ruby](https://www.ruby-lang.org/en/)
- [Ruby on Rails](https://rubyonrails.org/)

---
