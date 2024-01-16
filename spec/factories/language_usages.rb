# frozen_string_literal: true

FactoryBot.define do
  factory :language_usage do
    repository { create(:repository) }
    language_name { 'MyString' }
    byte_size { 1 }
  end
end
