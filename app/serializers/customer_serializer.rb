class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :updated_at, :created_at
end
