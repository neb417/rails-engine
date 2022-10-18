FactoryBot.define do
  factory :item do
    merchant
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph}
    unit_price { Faker::Number.within(range: 0.01..250.00).round(2) }
  end
end