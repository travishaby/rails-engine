require 'rails_helper'

RSpec.describe Customer, type: :model do
  context "valid cusotmer" do
    it "has all attributes respective to its tabel columns" do
      customer = Customer.new(first_name: "Travis", last_name: "Haby")

      expect(customer).to be_valid
    end

    let!(:cust1) { create(:customer) }
    let!(:merch1) { create(:merchant) }
    let!(:merch2) { create(:merchant, name: "other merchant") }
    let!(:invoice1) { create(:invoice,
                         customer_id: cust1.id,
                         merchant_id: merch1.id) }
    let!(:invoice2) { create(:invoice,
                         customer_id: cust1.id,
                         merchant_id: merch1.id) }
    let!(:invoice3) { create(:invoice,
                         customer_id: cust1.id,
                         merchant_id: merch2.id) }
    let!(:transaction1) { create(:transaction, invoice_id: invoice1.id) }
    let!(:transaction2) { create(:transaction, invoice_id: invoice2.id) }
    let!(:transaction3) { create(:transaction, invoice_id: invoice3.id) }

    it "returns favorite merchant" do
      # merch1 has two invoices, should return as favorite for cust1
      expect(cust1.favorite_merchant.id).to eq(merch1.id)
    end
  end
end
