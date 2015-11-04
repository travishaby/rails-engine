require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
  context "happy paths for invoices controller" do
    let(:invoice1) { create(:invoice) }
    let(:invoice2) { create(:invoice,
                              status: "pending",
                         merchant_id: invoice1.merchant_id) }
    let(:invoice3) { create(:invoice,
                         merchant_id: invoice1.merchant_id,
                         customer_id: invoice1.customer_id) }

    it "should display all invoices" do
      [invoice1, invoice2, invoice3]
      get :index, format: :json

      assert_response :success
      expect(parsed_body.size).to eq(3)
    end

    it "should display a single invoice" do
      get :show, format: :json, id: invoice2.id

      expect(parsed_body[:status]).to eq("pending")
    end

    it "should find a invoice by customer_id" do
      [invoice1, invoice2]
      get :find, format: :json, customer_id: invoice1.customer_id

      expect(parsed_body[:id]).to eq(invoice1.id)
    end

    it "should find all invoices by merchant_id" do
      [invoice1, invoice2, invoice3]
      get :find_all, format: :json, merchant_id: invoice1.merchant_id

      expect(parsed_body.size).to eq(3)
    end

    it "should return a random invoice" do
      [invoice1, invoice2, invoice3]
      get :random, format: :json
      found_invoice = Invoice.find_by(status: parsed_body[:status])

      expect(found_invoice).to be
    end
  end

  context "sad paths for invoices controller" do
    it "should return not found for show with nonexistent id" do
      get :show, format: :json, id: 2

      expect(response.body).to eq("null")
    end

    it "should return not found for no invoice for find_by" do
      get :find, format: :json, merchant_id: "pizza"

      expect(response.body).to eq("null")
    end

    it "should return not found for no invoice for find_all" do
      get :find_all, format: :json, customer_id: "Winnie the Pooh"

      expect(response.body).to eq("[]")
    end
  end
end