class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find_by(find_merchant_params)
  end

  def find_all
    respond_with Merchant.where(find_merchant_params)
  end

  def random
    respond_with Merchant.order("RANDOM()").first
  end

  private

  def find_merchant_params
    params.permit(:name)
  end
end
