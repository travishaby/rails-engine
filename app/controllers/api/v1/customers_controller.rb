class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

  def show
    if customer = Customer.find_by(id: params[:id])
      respond_with customer, status: 200
    else
      respond_with nil, status: 404
    end
  end

  def find
    if customer = Customer.find_by(find_customer_params)
      respond_with customer, status: 200
    else
      respond_with customer, status: 404
    end
  end

  def find_all
    customers = Customer.where(find_customer_params)
    if !customers.empty?
      respond_with customers, status: 200
    else
      respond_with nil, status: 404
    end
  end

  def random
    respond_with Customer.all.sample
  end

  private

  def find_customer_params
    params.permit(:first_name, :last_name)
  end
end
