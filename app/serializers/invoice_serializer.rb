class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :merchant_id, :customer_id, :status, :created_at, :updated_at
end
