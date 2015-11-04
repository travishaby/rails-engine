FactoryGirl.define do
  factory :invoice_item do
    item
    invoice
    quantity (1..10).to_a.sample
    unit_price (1..10000).to_a.sample
  end
end
