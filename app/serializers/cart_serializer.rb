class CartSerializer < ActiveModel::Serializer
  attributes :id, :product_name, :description, :price, :quantity, :total_price, :product_id
	belongs_to :customer
end
