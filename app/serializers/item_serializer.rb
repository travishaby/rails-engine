class ItemSerializer < ActiveModel::Serializer
  attributes :id, :merchant_id, :name, :description, :unit_price, :created_at, :updated_at

  def unit_price
    (object.unit_price).to_s
  end

end
