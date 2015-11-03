require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  context "happy paths for items controller" do
    let(:item1) { create(:item) }
    let(:item2) { create(:item, name: "Spicy Ranch", unit_price: 1000) }
    let(:item3) { create(:item, name: "Salad", unit_price: 1000) }

    it "should display all items" do
      [item1, item2]
      get :index, format: :json

      assert_response :success
      expect(parsed_body.size).to eq(2)
    end

    it "should display a single item" do
      get :show, format: :json, id: item1.id

      expect(parsed_body[:name]).to eq("Pizza")
    end

    it "should find a item by first name" do
      [item1, item2]
      get :find, format: :json, name: "Pizza"

      expect(parsed_body[:id]).to eq(item1.id)
    end

    it "should find all items by first name" do
      [item1, item2, item3]
      get :find_all, format: :json, unit_price: 1000

      expect(parsed_body.size).to eq(2)
    end

    it "should return a random item" do
      [item1, item2, item3]
      get :random, format: :json
      found_item = Item.find_by(name: parsed_body[:name])

      expect(found_item).to be
    end
  end

  context "sad paths for items controller" do
    it "should return not found for show with nonexistent id" do
      get :show, format: :json, id: 2

      expect(response.body).to eq("null")
    end

    it "should return not found for no item for find_by" do
      get :find, format: :json, name: "pizza"

      expect(response.body).to eq("null")
    end

    it "should return not found for no item for find_all" do
      get :find_all, format: :json, name: "Winnie the Pooh"

      expect(response.body).to eq("[]")
    end
  end
end
