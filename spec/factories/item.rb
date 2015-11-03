FactoryGirl.define do
  factory :item do
    name "Pizza"
    description FFaker::HipsterIpsum.sentence(5)
    unit_price (1..10000).to_a.sample
    merchant
  end
end
