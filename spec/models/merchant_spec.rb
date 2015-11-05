require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context "valid merchant" do
    it "has all attributes respective to its tabel columns" do
      merchant = Merchant.new(name: "Cosmo's")

      expect(merchant).to be_valid
    end

    let!(:cust1) { create(:customer) }
    let!(:merch1) { create(:merchant) }
    let!(:merch2) { create(:merchant, name: "Moe's") }
    let!(:invoice1) { create(:invoice,
                         customer_id: cust1.id,
                         merchant_id: merch1.id) }
    let!(:invoice2) { create(:invoice,
                         customer_id: cust1.id,
                         merchant_id: merch2.id) }
    let!(:invoice_item1) { create(:invoice_item,
                                 item_id: item1.id,
                              invoice_id: invoice1.id,
                                quantity: 10,
                              unit_price: 1000.0) }
    let!(:invoice_item2) { create(:invoice_item,
                                 item_id: item2.id,
                              invoice_id: invoice2.id,
                                quantity: 15,
                              unit_price: 10.0) }
    let!(:item1) { create(:item)}
    let!(:item2) { create(:item, name: "other item")}
    let!(:transaction1) { create(:transaction, invoice_id: invoice1.id) }
    let!(:transaction2) { create(:transaction, invoice_id: invoice2.id) }

    it "returns most revenue for given number of merchants" do
      merchants = Merchant.most_revenue(1)
      expect(merchants.size).to eq(1)
      expect(merchants.first).to eq(merch1)
    end

    it "returns most items for given number of merchants" do
      merchants = Merchant.most_items(1)
      expect(merchants.size).to eq(1)
      expect(merchants.first).to eq(merch2)
    end
  end
end
