class Customer < ApplicationRecord
	belongs_to :user
	has_many :carts
	before_create :validate_date_of_birth, :downcase_email
	before_update :validate_date_of_birth, :downcase_email

	validates :name, :date_of_birth, :address,:gender, presence: true
	validates :mobile_number, presence: true, numericality: true, length: {is: 10}
	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
	GENDER = ['Male', 'Female']
	has_secure_password
	private
	# For giving proper date format
	def validate_date_of_birth
		if self.date_of_birth
			self.date_of_birth = self.date_of_birth.to_date
		else
			self.date_of_birth = nil
		end
	end
	def downcase_email
		self.email = email.downcase
	end
end
