class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with find_merchant
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

  def items
    respond_with find_merchant.items
  end

  def invoices
    respond_with find_merchant.invoices
  end

  def revenue
    respond_with revenue: find_merchant.revenue(find_merchant_params[:date]).to_s
  end

  private

  def find_merchant
    Merchant.find_by(id: params[:id])
  end

  def find_merchant_params
    params.permit(:id,
                  :name,
                  :created_at,
                  :updated_at,
                  :date)
  end
end
