require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context "valid transaction" do
    it "has all attributes respective to its tabel columns" do
      transaction = Transaction.new(invoice_id: "Pizza",
                            credit_card_number: "4242424242424242",
                   credit_card_expiration_date: Date.today,
                                        result: "success")

      expect(transaction).to be_valid
    end

    let!(:trans1) { create(:transaction) }
    let!(:trans2) { create(:transaction, result: "failed") }

    it "returns only unsuccessful transactions" do
      expect(Transaction.unsuccessful.first).to eq(trans2)
    end
  end
end
