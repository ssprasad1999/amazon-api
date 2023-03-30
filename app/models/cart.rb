class Cart < ApplicationRecord
	belongs_to :customer
	before_create :set_quantity
	before_update :set_price
	validates :product_id, :product_name, :description, :price, presence: true
	validates :quantity, acceptance: {accept: 1..10}
	private
	def set_quantity
		self.quantity=1
		self.total_price=price
	end
	def set_price
		self.total_price=price*quantity
	end
end
