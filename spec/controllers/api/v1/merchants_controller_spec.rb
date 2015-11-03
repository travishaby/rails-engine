require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  context "happy paths for merchants controller" do
    let(:merch1) { create(:merchant) }
    let(:merch2) { create(:merchant, name: "Moe's") }
    let(:merch3) { create(:merchant, name: "Snarf's") }

    it "should display all merchants" do
      [merch1, merch2]
      get :index, format: :json

      assert_response :success
      expect(parsed_body.size).to eq(2)
    end

    it "should display a single merchant" do
      get :show, format: :json, id: merch1.id

      expect(parsed_body[:name]).to eq("Cosmo's")
    end

    it "should find a merchant by first name" do
      [merch1, merch2]
      get :find, format: :json, name: "Cosmo's"

      expect(parsed_body[:id]).to eq(merch1.id)
    end

    it "should find all merchants by first name" do
      [merch1, merch2]
      get :find_all, format: :json, last_name: "haby"

      expect(parsed_body.size).to eq(2)
    end

    it "should return a random merchant" do
      [merch1, merch2, merch3]
      get :random, format: :json
      found_merchant = Merchant.find_by(name: parsed_body[:name])

      expect(found_merchant).to be
    end
  end

  context "sad paths for merchants controller" do
    it "should return not found for show with nonexistent id" do
      get :show, format: :json, id: 2

      expect(response.body).to eq("null")
    end

    it "should return not found for no merchant for find_by" do
      get :find, format: :json, first_name: "Travis"

      expect(response.body).to eq("null")
    end

    it "should return not found for no merchant for find_all" do
      get :find_all, format: :json, first_name: "Winnie the Pooh"

      expect(response.body).to eq("[]")
    end
  end
end
