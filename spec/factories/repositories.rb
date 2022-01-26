FactoryBot.define do
  factory :repository do
    name { "my/string" }
    category { build(:category) }
  end
end
