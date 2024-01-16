require 'rails_helper'

RSpec.describe UserRankingCalculator do
  describe '.calculate' do
    let(:user) { create(:user) }
    let(:repo_with_stars) { create(:repository, user:, star_count: 10) }
    let(:repo_with_ruby) { create(:repository, user:) }
    let(:repo_with_golang) { create(:repository, user:) }

    before do
      create(:language_usage, repository: repo_with_ruby, language_name: 'Ruby')
      create(:language_usage, repository: repo_with_golang, language_name: 'Golang')
      user.repositories << [repo_with_stars, repo_with_ruby, repo_with_golang]
    end

    it 'correctly calculates the ranking score' do
      expected_score = UserRankingCalculator::REPO_WEIGHT * user.repositories.count +
                       UserRankingCalculator::STAR_WEIGHT * user.repositories.sum(:star_count) +
                       UserRankingCalculator::LANGUAGE_WEIGHT * 1 +
                       UserRankingCalculator::PENALTY_WEIGHT * 1

      expect(UserRankingCalculator.calculate(user)).to eq(expected_score)
    end
  end
end
