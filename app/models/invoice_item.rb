class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoice
  
  before_save :convert_unit_price

  def convert_unit_price
    self.unit_price = self.unit_price/100
  end
end
