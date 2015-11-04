class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  def revenue(date = nil)
    if date
      invoice_items.joins(:invoice)
                   .where(invoices: { created_at: date } )
                   .joins(:transactions)
                   .where(transactions: {result: "success"} )
                   .sum("quantity * unit_price")
    else
      invoice_items
                   .joins(:transactions)
                   .where(transactions: {result: "success"} )
                   .sum("quantity * unit_price")
    end
  end

  def favorite_customer
    customers
            .select("customers.*, count(invoices.customer_id) AS inv_count")
            .joins(invoices: :transactions)
            .merge(Transaction.successful)
            .group("customers.id")
            .order("inv_count DESC")
            .first.id
  end
end
