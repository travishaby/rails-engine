require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  context "valid invoice_item" do
    it "has all attributes respective to its tabel columns" do
      invoice_item = InvoiceItem.new(item_id: 1,
                                  invoice_id: 1,
                                    quantity: 10,
                                  unit_price: 10.0)

      expect(invoice_item).to be_valid
    end
  end
end
