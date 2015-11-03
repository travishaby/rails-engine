class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice
  belongs_to :customer, through: :invoices
end
