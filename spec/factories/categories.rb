FactoryBot.define do
  factory :category do
    name { "MyString" }
    technology { build(:technology) }
  end
end
