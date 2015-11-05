class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.total_revenue(date)
    joins(invoice_items: :invoice)
      .where(invoices: { created_at: date })
      .sum("quantity * unit_price").to_s
  end

  def self.most_revenue(quantity)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .joins(:invoice_items)
      .group("merchants.id")
      .order("revenue DESC")
      .first(quantity.to_i)
  end

  def self.most_items(quantity)
    select("merchants.*, sum(invoice_items.quantity) as item_count")
      .joins(:invoice_items)
      .group("merchants.id")
      .order("item_count DESC")
      .includes(:invoices, :transactions)
      .merge(InvoiceItem.successful)
      .first(quantity.to_i)
  end

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

  def customers_with_pending_invoices
    result = customers
             .joins(invoices: :transactions)
             .where(transactions: { result: "failed"  })
             .uniq.size
  end
end
