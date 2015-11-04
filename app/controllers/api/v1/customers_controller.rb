class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def find
    respond_with Customer.find_by(find_customer_params)
  end

  def find_all
    respond_with Customer.where(find_customer_params)
  end

  def random
    respond_with Customer.order("RANDOM()").first
  end

  def invoices
    respond_with find_customer.invoices
  end

  def transactions
    respond_with find_customer.transactions
  end

  private

  def find_customer_params
    params.permit(:id,
                  :first_name,
                  :last_name,
                  :created_at,
                  :updated_at)
  end

  def find_customer
    Customer.find_by(id: params[:id])
  end
end
