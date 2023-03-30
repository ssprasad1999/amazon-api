class Seller < ApplicationRecord
	belongs_to :user
	has_many :products
	before_create :set_seller_creation_date, :downcase_seller_email

	validates :store_name, presence: true, uniqueness: {case_sensitive: false}, length: { minimum: 5 }
	validates :seller_name, :seller_address, presence: true, length: { minimum: 3 }
	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
	has_secure_password
	private
	def set_seller_creation_date
		self.seller_creation_date = self.created_at.to_date
	end
	def downcase_seller_email
		self.seller_email = seller_email.downcase
	end
end
