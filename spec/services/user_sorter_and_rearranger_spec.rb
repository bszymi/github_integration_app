# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSorterAndRearranger do
  describe '.sort_and_rearrange_users' do
    let!(:users) { create_list(:user, 5).reverse }

    before do
      # Mock UserRankingCalculator to always return 0
      allow(UserRankingCalculator).to receive(:calculate).and_return(0)
    end

    def set_star_counts(star_counts)
      star_counts.each_with_index do |count, index|
        create(:repository, user: users[index], star_count: count)
      end
    end

    context 'no rearrangement needed' do
      it 'returns users in their original order' do
        set_star_counts([20, 15, 10, 5, 0])

        expect(UserSorterAndRearranger.sort_and_rearrange_users.map(&:id)).to eq(users.map(&:id))
      end
    end

    context 'simple rearrangement' do
      it 'rearranges users correctly' do
        set_star_counts([20, 15, 14, 10, 5])
        expected_order = [users[0], users[1], users[3], users[2], users[4]].map(&:id)
        expect(UserSorterAndRearranger.sort_and_rearrange_users.map(&:id)).to eq(expected_order)
      end
    end

    context 'complex rearrangement' do
      it 'rearranges users correctly' do
        set_star_counts([20, 15, 14, 13, 5])
        expected_order = [users[0], users[1], users[4], users[2], users[3]].map(&:id)
        expect(UserSorterAndRearranger.sort_and_rearrange_users.map(&:id)).to eq(expected_order)
      end
    end

    context 'no rearrangement needed when all have similar number of stars' do
      it 'returns users in their original order' do
        set_star_counts([20, 19, 20, 19, 20])
        expect(UserSorterAndRearranger.sort_and_rearrange_users.map(&:id)).to eq(users.map(&:id))
      end
    end

  end
end

