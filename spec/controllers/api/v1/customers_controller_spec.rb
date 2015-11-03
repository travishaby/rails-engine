require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  context "happy paths for customers controller" do
    it "should display all customers" do
      create(:customer)
      create(:customer, first_name: "lani", last_name: "young")

      get :index, format: :json

      assert_response :success

      customers = JSON.parse(response.body)
      expect(customers.size).to eq(2)
    end

    it "should display a single customer" do
      customer = create(:customer)
      get :show, format: :json, id: customer.id

      response_customer = JSON.parse(response.body, symbolize_names: true)

      expect(response_customer[:last_name]).to eq("Haby")
    end

    it "should find a customer by first name" do
      customer = create(:customer)
      create(:customer, first_name: "lani", last_name: "young")
      get :find, format: :json, first_name: "Travis"

      response_customer = JSON.parse(response.body, symbolize_names: true)

      expect(response_customer[:id]).to eq(customer.id)
    end

    it "should find all customers by first name" do
      create(:customer)
      create(:customer, first_name: "travis", last_name: "baby")
      get :find_all, format: :json, first_name: "travis"

      customers = JSON.parse(response.body, symbolize_names: true)

      expect(customers.size).to eq(2)
    end

    it "should return a random customer" do
      cust1 = create(:customer)
      cust2 = create(:customer, first_name: "lani")
      cust3 = create(:customer, first_name: "bret")

      get :random, format: :json

      customer = JSON.parse(response.body, symbolize_names: true)

      found_customer = Customer.find_by(first_name: customer[:first_name])

      expect(found_customer).to be
    end
  end
  context "sad paths for customers controller" do
    it "should return not found for show with nonexistent id" do
      cust1 = create(:customer)
      get :show, format: :json, id: 2

      expect(response).to eq(:not_found)
    end
  end
end
