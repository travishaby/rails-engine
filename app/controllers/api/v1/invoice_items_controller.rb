class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def find
    respond_with InvoiceItem.find_by(find_invoice_item_params)
  end

  def find_all
    respond_with InvoiceItem.where(find_invoice_item_params)
  end

  def random
    respond_with InvoiceItem.order("RANDOM()").first
  end

  def item
    respond_with find_invoice_item.item
  end

  def invoice
    respond_with find_invoice_item.invoice
  end

  private

  def find_invoice_item
    InvoiceItem.find_by(id: params[:id])
  end

  def find_invoice_item_params
    modify_unit_price
    params.permit(:id,
                  :item_id,
                  :invoice_id,
                  :quantity,
                  :unit_price,
                  :created_at,
                  :updated_at)
  end

  def modify_unit_price
    params[:unit_price] = params[:unit_price].to_f if params[:unit_price]
  end
end
