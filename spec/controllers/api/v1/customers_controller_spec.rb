require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do

  context "get request for customer controller" do
    it "should display all customers" do
      Customer.create(first_name: "travis", last_name: "haby")
      Customer.create(first_name: "lani", last_name: "young")

      get :index, format: :json

      assert_response :success

      customers = JSON.parse(response.body)
      expect(customers.size).to eq(2)
    end

    it "should display a single customer" do
      customer = Customer.create(first_name: "lani", last_name: "young")
      get :show, format: :json, id: customer.id

      response_customer = JSON.parse(response.body, symbolize_names: true)

      expect(response_customer[:last_name]).to eq("young")
    end

    it "should find a customer by first name" do
      Customer.create(first_name: "travis", last_name: "haby")
      customer = Customer.create(first_name: "lani", last_name: "young")

      get :find, format: :json, first_name: "lani"

      response_customer = JSON.parse(response.body, symbolize_names: true)

      expect(response_customer[:id]).to eq(customer.id)
    end
  end

end
