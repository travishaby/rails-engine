class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

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
end
