require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  context "happy paths for transactions controller" do
    let(:transaction1) { create(:transaction) }
    let(:transaction2) { create(:transaction,
                          credit_card_number: transaction1.credit_card_number) }
    let(:transaction3) { create(:transaction,
                                      result: "failure",
                          credit_card_number: "1111222233334444",
                                  invoice_id: transaction1.invoice_id) }

    it "should display all transactions" do
      [transaction1, transaction2, transaction3]
      get :index, format: :json

      assert_response :success
      expect(parsed_body.size).to eq(3)
    end

    it "should display a single transaction" do
      get :show, format: :json, id: transaction2.id

      expect(parsed_body[:credit_card_number]).to eq(transaction2.credit_card_number)
    end

    it "should find a transaction by invoice_id" do
      [transaction1, transaction2]
      get :find, format: :json, invoice_id: transaction1.invoice_id

      expect(parsed_body[:invoice_id]).to eq(transaction1.invoice_id)
    end

    it "should find all transactions by cc number" do
      [transaction1, transaction2, transaction3]
      get :find_all, format: :json, credit_card_number: transaction1.credit_card_number

      expect(parsed_body.size).to eq(2)
    end

    it "should return a random transaction" do
      [transaction1, transaction2, transaction3]
      get :random, format: :json
      found_transaction = Transaction.find_by(result: parsed_body[:result])

      expect(found_transaction).to be
    end
  end

  context "sad paths for transactions controller" do
    it "should return not found for show with nonexistent id" do
      get :show, format: :json, id: 2

      expect(response.body).to eq("null")
    end

    it "should return not found for no transaction for find_by" do
      get :find, format: :json, invoice_id: "pizza"

      expect(response.body).to eq("null")
    end

    it "should return not found for no transaction for find_all" do
      get :find_all, format: :json, result: "Winnie the Pooh"

      expect(response.body).to eq("[]")
    end
  end

  context "happy paths for invoices controller relationship routes" do
    let!(:transaction1) { create(:transaction, invoice_id: invoice1.id) }
    let!(:invoice1) { create(:invoice) }

    it "should display transaction for an invoice" do
      get :invoice, format: :json, id: transaction1.id

      expect(parsed_body[:id]).to eq(invoice1.id)
    end
  end
end
