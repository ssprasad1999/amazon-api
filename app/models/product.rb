class Product < ApplicationRecord
	belongs_to :seller
	
	before_create :calculate_offer_price
	before_update :calculate_offer_price

	validates :product_name, :brand, :actual_price, :description, :category, presence: true
	validates :actual_price, :offer, numericality: true
	validates_acceptance_of :offer, :in => 1..100
	private
	# For generating the offer_price of product
	def calculate_offer_price
		if self.offer.present?
			self.offer_price = self.actual_price - (self.offer*self.actual_price)/100.0
		else
			self.offer_price = self.actual_price
		end
	end
end
