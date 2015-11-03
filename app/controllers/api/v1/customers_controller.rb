class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

  def show
    if customer = Customer.find(params[:id])
      respond_with customer, status: 200
    else
      respond_with status: 404
    end
  end

  def find
    if customer = Customer.find_by(find_customer_params)
      respond_with customer, status: 200
    else
      respond_with status: 404
    end
  end

  def find_all
    respond_with Customer.where(find_customer_params)
  end

  def random
    respond_with Customer.all.sample
  end

  private

  def find_customer_params
    params.permit(:first_name, :last_name)
  end
end
