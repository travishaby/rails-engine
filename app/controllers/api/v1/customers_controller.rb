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

  private

  def find_customer_params
    params.permit(:first_name, :last_name)
  end
end
