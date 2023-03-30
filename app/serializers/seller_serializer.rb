class SellerSerializer < ActiveModel::Serializer
  attributes :id, :seller_name, :seller_email, :store_name, :seller_address, :seller_creation_date
	has_many :products

	def store_name
		self.object.store_name.upcase
	end
end
