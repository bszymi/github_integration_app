# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:language_usages) }
  end

  describe 'validations' do
    let(:user) { create(:user) }

    before do
      create(:repository, user: user, name: "MyString")
    end

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }
  end
end
