FactoryBot.define do
  factory :repository do
    user { create(:user) }
    name { "MyString" }
    star_count { 1 }
  end
end
