# frozen_string_literal: true

FactoryBot.define do
  factory :repository do
    user { create(:user) }
    name { Faker::String.random(length: 5..10) }
    star_count { 1 }
  end
end
