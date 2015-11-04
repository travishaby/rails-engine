require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do

  context "single merchant business intelligence routes" do
    let!(:merch1) { create(:merchant) }
    let!(:item1) { create(:item,
                           name: "Pizza",
                    merchant_id: merch1.id) }
    let!(:item2) { create(:item,
                           name: "Spicy Ranch",
                    merchant_id: merch1.id) }
    let!(:invoice1) { create(:invoice, merchant_id: merch1.id) }
    let!(:invoice2) { create(:invoice,
                         merchant_id: merch1.id,
                          created_at: "2012-03-16 11:55:05") }
    let!(:invoice3) { create(:invoice, merchant_id: merch1.id) }
    let!(:invoice_item_1) { create(:invoice_item,
                                      invoice_id: invoice1.id,
                                         item_id: item1.id,
                                        quantity: 10,
                                      unit_price: 1000) }
    let!(:invoice_item_2) { create(:invoice_item,
                                      invoice_id: invoice2.id,
                                         item_id: item2.id,
                                        quantity: 4,
                                      unit_price: 2000) }
    let!(:invoice_item_3) { create(:invoice_item,
                                      invoice_id: invoice3.id,
                                         item_id: item2.id,
                                      unit_price: 2000) }
    let!(:transaction1) { create(:transaction, invoice_id: invoice1.id) }
    let!(:transaction2) { create(:transaction, invoice_id: invoice2.id) }
    let!(:transaction3) { create(:transaction,
                                   invoice_id: invoice3.id,
                                       result: "failed") }

    #INVOICE THREE IS PENDING SO ONLY INVOICE1 SHOULD RETURN

    it "should display total revenue for a single merchant" do
      get :revenue, format: :json, id: merch1.id

      expect(parsed_body[:revenue]).to eq("180.0")
    end

    it "should display total revenue for a single merchant on a given day" do
      get :revenue, format: :json,
                        id: merch1.id,
                      date: invoice2.created_at

      expect(parsed_body[:revenue]).to eq("80.0")
    end
  end

end
