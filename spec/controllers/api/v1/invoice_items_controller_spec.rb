require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do
  context "happy paths for invoice_items controller" do
    let!(:invoice_item1) { create(:invoice_item,
                                     unit_price: 1000) }
    let!(:invoice_item2) { create(:invoice_item,
                                       item_id: invoice_item1.item_id,
                                    unit_price: 1000) }
    let!(:invoice_item3) { create(:invoice_item,
                                       item_id: invoice_item1.item_id,
                                    invoice_id: invoice_item1.invoice_id,
                                    unit_price: 1000) }

    it "should display all invoice_items" do
      get :index, format: :json

      assert_response :success
      expect(parsed_body.size).to eq(3)
    end

    it "should display a single invoice_item" do
      get :show, format: :json, id: invoice_item2.id

      expect(parsed_body[:item_id]).to eq(invoice_item2.item_id)
    end

    it "should find a invoice_item by unit_price" do
      #mimicing the spec harness' query format
      get :find, format: :json, unit_price: (invoice_item1.unit_price).to_s

      expect(parsed_body[:invoice_id]).to eq(invoice_item1.invoice_id)
    end

    it "should find all invoice_items by item_id" do
      get :find_all, format: :json, item_id: invoice_item1.item_id

      expect(parsed_body.size).to eq(3)
    end

    it "should return a random invoice_item" do
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
      get :find, format: :json, merchant_id: 1

      expect(response.body).to eq("null")
    end

    it "should return not found for no invoice_item for find_all" do
      get :find_all, format: :json, customer_id: 2

      expect(response.body).to eq("[]")
    end
  end

  context "happy paths for invoices controller relationship routes" do
    let!(:invoice_item1) { create(:invoice_item,
                                 item_id: item1.id,
                              invoice_id: invoice1.id) }
    let!(:invoice1) { create(:invoice) }
    let!(:item1) { create(:item)}

    let!(:invoice2) { create(:invoice) }
    let!(:item2) { create(:item, name: "Not included") }

    it "should display the associated item for an invoice item" do
      get :item, format: :json, id: invoice_item1.id

      expect(parsed_body[:id]).to eq(item1.id)
    end

    it "should display the associated invoice for an invoice item" do
      get :invoice, format: :json, id: invoice_item1.id

      expect(parsed_body[:id]).to eq(invoice1.id)
    end
  end
end
