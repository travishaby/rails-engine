class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.all
  end

  def show
    respond_with find_item
  end

  def find
    respond_with Item.find_by(find_item_params)
  end

  def find_all
    respond_with Item.where(find_item_params)
  end

  def random
    respond_with Item.order("RANDOM()").first
  end

  def invoice_items
    respond_with find_item.invoice_items
  end

  def merchant
    respond_with find_item.merchant
  end

  private

  def find_item_params
    unit_price_to_f
    params.permit(:id,
                  :name,
                  :description,
                  :unit_price,
                  :merchant_id,
                  :created_at,
                  :updated_at,
                  :quantity)
  end

  def find_item
    Item.find_by(id: params[:id])
  end

  def unit_price_to_f
    params[:unit_price] = params[:unit_price].to_f if params[:unit_price]
  end
end
