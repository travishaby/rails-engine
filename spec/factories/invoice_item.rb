FactoryGirl.define do
  factory :invoice_item do
    item
    invoice
    quantity (1..10).to_a.sample
    item.unit_price
  end
end
