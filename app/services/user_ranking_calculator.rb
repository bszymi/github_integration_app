# frozen_string_literal: true

class UserRankingCalculator
  STAR_WEIGHT = 3
  REPO_WEIGHT = 2
  LANGUAGE_WEIGHT = 2
  PENALTY_WEIGHT = -1

  def self.calculate(user)
    new(user).calculate
  end

  def initialize(user)
    @user = user
  end

  def calculate
    score = REPO_WEIGHT * @user.repositories.count
    score += STAR_WEIGHT * @user.repositories.sum(:star_count)
    score += LANGUAGE_WEIGHT * ruby_or_python_count
    score += PENALTY_WEIGHT * golang_or_typescript_count
    score
  end

  private

  def ruby_or_python_count
    @user.repositories.joins(:language_usages).where(language_usages: { language_name: ['Ruby', 'Python'] }).count
  end

  def golang_or_typescript_count
    @user.repositories.joins(:language_usages).where(language_usages: { language_name: ['Golang', 'TypeScript'] }).count
  end
end
