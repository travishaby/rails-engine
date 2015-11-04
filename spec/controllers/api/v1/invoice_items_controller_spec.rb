require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do
  context "happy paths for invoice_items controller" do
    let(:invoice_item1) { create(:invoice_item) }
    let(:invoice_item2) { create(:invoice_item,
                                       item_id: invoice_item1.item_id) }
    let(:invoice_item3) { create(:invoice_item,
                                       item_id: invoice_item1.item_id,
                                    invoice_id: invoice_item1.invoice_id) }

    it "should display all invoice_items" do
      [invoice_item1, invoice_item2, invoice_item3]
      get :index, format: :json

      assert_response :success
      expect(parsed_body.size).to eq(3)
    end

    it "should display a single invoice_item" do
      get :show, format: :json, id: invoice_item2.id

      expect(parsed_body[:item_id]).to eq(invoice_item2.item_id)
    end

    it "should find a invoice_item by customer_id" do
      [invoice_item1, invoice_item2]
      get :find, format: :json, invoice_id: invoice_item1.invoice_id

      expect(parsed_body[:invoice_id]).to eq(invoice_item1.invoice_id)
    end

    it "should find all invoice_items by merchant_id" do
      [invoice_item1, invoice_item2, invoice_item3]
      get :find_all, format: :json, item_id: invoice_item1.item_id

      expect(parsed_body.size).to eq(3)
    end

    it "should return a random invoice_item" do
      [invoice_item1, invoice_item2, invoice_item3]
      get :random, format: :json
      found_invoice_item = InvoiceItem.find_by(id: parsed_body[:id])

      expect(found_invoice_item).to be
    end
  end

  context "sad paths for invoice_items controller" do
    it "should return not found for show with nonexistent id" do
      get :show, format: :json, id: 2

      expect(response.body).to eq("null")
    end

    it "should return not found for no invoice_item for find_by" do
      get :find, format: :json, merchant_id: "pizza"

      expect(response.body).to eq("null")
    end

    it "should return not found for no invoice_item for find_all" do
      get :find_all, format: :json, customer_id: "Winnie the Pooh"

      expect(response.body).to eq("[]")
    end
  end
end
