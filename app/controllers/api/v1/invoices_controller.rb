class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find_by(id: params[:id])
  end

  def find
    respond_with Invoice.find_by(find_invoice_params)
  end

  def find_all
    respond_with Invoice.where(find_invoice_params)
  end

  def random
    respond_with Invoice.order("RANDOM()").first
  end

  def items
    respond_with find_invoice.items
  end

  def invoice_items
    respond_with find_invoice.invoice_items
  end

  def transactions
    respond_with find_invoice.transactions
  end

  def customer
    respond_with find_invoice.customer
  end

  def merchant
    respond_with find_invoice.merchant
  end

  private

  def find_invoice_params
    params.permit(:id,
                  :customer_id,
                  :merchant_id,
                  :status)
  end

  def find_invoice
    Invoice.find_by(id: params[:id])
  end
end
