require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  context "happy paths for customers controller" do
    let!(:cust1) { create(:customer) }
    let!(:cust2) { create(:customer, first_name: "lani") }
    let!(:cust3) { create(:customer, first_name: "bret") }

    it "should display all customers" do
      get :index, format: :json

      expect(parsed_body.size).to eq(3)
    end

    it "should display a single customer" do
      get :show, format: :json, id: cust1.id

      expect(parsed_body[:last_name]).to eq("Haby")
    end

    it "should find a customer by first name" do
      get :find, format: :json, last_name: "Haby"

      expect(parsed_body[:id]).to eq(cust1.id)
    end

    it "should find all customers by first name" do
      get :find_all, format: :json, last_name: "Haby"

      expect(parsed_body.size).to eq(3)
    end

    it "should return a random customer" do
      get :random, format: :json
      found_customer = Customer.find_by(first_name: parsed_body[:first_name])

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

  context "happy paths for customers controller relationship routes" do
    let!(:cust1) { create(:customer) }
    let!(:invoice1) { create(:invoice,
                         customer_id: cust1.id) }
    let!(:invoice2) { create(:invoice,
                         customer_id: cust1.id) }
    let!(:transaction1) { create(:transaction, invoice_id: invoice1.id) }
    let!(:transaction2) { create(:transaction, invoice_id: invoice2.id) }
    let!(:transaction3) { create(:transaction) } #shouldn't be connected

    it "should display all invoices for a customer" do
      get :invoices, format: :json, id: cust1.id

      expect(parsed_body.size).to eq(2)
    end


    it "should display all transactions for a customer" do
      get :transactions, format: :json, id: cust1.id

      expect(parsed_body.size).to eq(2)
    end
  end
end
