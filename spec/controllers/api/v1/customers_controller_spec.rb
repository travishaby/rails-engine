require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  context "happy paths for customers controller" do
    let(:cust1) { create(:customer) }
    let(:cust2) { create(:customer, first_name: "lani") }
    let(:cust3) { create(:customer, first_name: "bret") }

    it "should display all customers" do
      create(:customer)
      create(:customer, first_name: "lani", last_name: "young")
      get :index, format: :json

      assert_response :success

      customers = JSON.parse(response.body)
      expect(customers.size).to eq(2)
    end

    it "should display a single customer" do
      get :show, format: :json, id: cust1.id
      response_customer = JSON.parse(response.body, symbolize_names: true)

      expect(response_customer[:last_name]).to eq("Haby")
    end

    it "should find a customer by first name" do
      [cust1, cust2]
      get :find, format: :json, first_name: "Travis"
      response_customer = JSON.parse(response.body, symbolize_names: true)

      expect(response_customer[:id]).to eq(cust1.id)
    end

    it "should find all customers by first name" do
      create(:customer)
      create(:customer, first_name: "travis", last_name: "baby")
      get :find_all, format: :json, first_name: "travis"
      customers = JSON.parse(response.body, symbolize_names: true)

      expect(customers.size).to eq(2)
    end

    it "should return a random customer" do
      [cust1, cust2, cust3]
      get :random, format: :json
      customer = JSON.parse(response.body, symbolize_names: true)
      found_customer = Customer.find_by(first_name: customer[:first_name])

      expect(found_customer).to be
    end
  end

  context "sad paths for customers controller" do
    it "should return not found for show with nonexistent id" do
      get :show, format: :json, id: 2

      expect(response.body).to eq("null")
    end

    it "should return not found for no customer for find_by" do
      get :find, format: :json, first_name: "Travis"

      expect(response.body).to eq("null")
    end

    it "should return not found for no customer for find_all" do
      get :find_all, format: :json, first_name: "Winnie the Pooh"

      expect(response.body).to eq("[]")
    end
  end
end
