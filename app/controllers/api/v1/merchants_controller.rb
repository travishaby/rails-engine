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

  def items
    respond_with find_merchant.items
  end

  def invoices
    respond_with find_merchant.invoices
  end

  def revenue
    revenue = find_merchant.successful_invoices
    merchant_revenue = {revenue: revenue}
    respond_with merchant_revenue
  end

  private

  def find_merchant
    Merchant.find_by(id: params[:id])
  end

  def find_merchant_params
    params.permit(:id,
                  :name,
                  :created_at,
                  :updated_at)
  end
end
