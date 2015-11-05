require 'rails_helper'

RSpec.describe Item, type: :model do
  context "valid item" do
    it "has all attributes respective to its tabel columns" do
      item = Item.new(name: "Pizza",
                   description: "Hey, that's delicious!",
                    unit_price: 100.0,
                   merchant_id: 1)

      expect(item).to be_valid
    end
  end
end
