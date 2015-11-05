class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  scope :pending, -> { joins(:transactions).merge(Transaction.unsuccessful)}

  scope :successful, -> { joins(:transactions).merge(Transaction.successful)}
end
