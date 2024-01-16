# frozen_string_literal: true

class UserSorterAndRearranger
  def self.sort_and_rearrange_users
    sorted_users = User.all.sort_by { |user| UserRankingCalculator.calculate(user) }.reverse
    rearrange_users(sorted_users)
  end

  def self.rearrange_users(sorted_users)
    rearranged = []
    while sorted_users.any?
      user_to_move = find_next_eligible_user(rearranged.last, sorted_users)
      rearranged << user_to_move
      sorted_users.delete(user_to_move)
    end
    rearranged
  end

  def self.find_next_eligible_user(last_user, remaining_users)
    return remaining_users.first if last_user.nil?

    remaining_users.find(-> { remaining_users.first }) do |user|
      (user.repositories.sum(:star_count) - last_user.repositories.sum(:star_count)).abs > 2
    end
  end
end
