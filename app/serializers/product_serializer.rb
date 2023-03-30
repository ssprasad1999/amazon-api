class ProductSerializer < ActiveModel::Serializer
  attributes :id, :product_name, :brand, :actual_price, :offer, :offer_price
	belongs_to :seller

	def actual_price
		# To format the price as Rs.2324.00/-
		"Rs.#{'%.2f' % self.object.actual_price}/-"
	end
	def offer
		# To format the offer as 15%
		"#{self.object.offer}% off"
	end
	def offer_price
		"Rs.#{'%.2f' % self.object.offer_price}/-"
	end
end
