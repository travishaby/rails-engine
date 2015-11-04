class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  has_many :invoice_items, through: :invoices

  def favorite_merchant
      merchants
              .select("merchants.*, count(invoices.merchant_id) AS inv_count")
              .joins(invoices: :transactions)
              .merge(Transaction.successful)
              .group("merchants.id")
              .order("inv_count DESC")
              .first
  end
end
