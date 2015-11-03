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

    it "should find all customers by first name" do
      Customer.create(first_name: "travis", last_name: "haby")
      Customer.create(first_name: "travis", last_name: "baby")

      get :find_all, format: :json, first_name: "travis"

      customers = JSON.parse(response.body, symbolize_names: true)

      expect(customers.size).to eq(2)
    end


    it "should return a random customer" do
      cust1 = Customer.create(first_name: "travis", last_name: "haby")
      cust2 = Customer.create(first_name: "lani", last_name: "young")
      cust3 = Customer.create(first_name: "bret", last_name: "doucette")

      get :random, format: :json

      customer = JSON.parse(response.body, symbolize_names: true)

      found_customer = Customer.find_by(first_name: customer[:first_name])

      expect(found_customer).to be
    end
  end

end
