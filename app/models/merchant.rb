class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def successful_invoices
    successful_invoice_items = invoice_items
                               .includes(:transactions)
                               .joins(:transactions)
                               .where(transactions: {result: "success"})

    binding.pry
  end
end
