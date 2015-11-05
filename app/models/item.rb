class Item < ActiveRecord::Base
  default_scope { order(:id) }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  before_save :convert_unit_price

  def convert_unit_price
    self.unit_price = self.unit_price/100
  end

  def self.most_revenue(quantity)
    invoices
            .successful
            .includes(:transactions, :invoices, :invoice_items)
  end
end
