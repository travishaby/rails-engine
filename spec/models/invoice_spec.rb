require 'rails_helper'

RSpec.describe Invoice, type: :model do
  context "valid invoice" do
    it "has all attributes respective to its tabel columns" do
      invoice = Invoice.new(customer_id: 1,
                            merchant_id: 1,
                                 status: "pending")

      expect(invoice).to be_valid
    end
  end
end
