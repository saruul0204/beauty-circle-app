FactoryBot.define do
  factory :treatment do
    name { "MyString" }
    description { "MyText" }
    price { "MyString" }
    duration { "MyString" }
    business { nil }
  end
end
