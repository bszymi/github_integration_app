# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LanguageUsage, type: :model do
  describe 'associations' do
    it { should belong_to(:repository) }
  end

  describe 'validations' do
    let(:repository) { create(:repository) }

    before do
      create(:language_usage, repository: repository, language_name: "Ruby")
    end

    it { should validate_presence_of(:language_name) }
    it { should validate_uniqueness_of(:language_name).scoped_to(:repository_id).case_insensitive }
  end
end
