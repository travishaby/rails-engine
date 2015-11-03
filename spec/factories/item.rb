FactoryGirl.define do
  factory :item do
    name "Pizza"
    description FFaker::HipsterIpsum.word(5)
  end
end

    t.citext   "name"
    t.string   "description"
    t.float    "unit_price"
    t.integer  "merchant_id"
