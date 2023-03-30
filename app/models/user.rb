class User < ApplicationRecord
	has_one :seller
	has_one :customer
	validates :email, :password, presence: true, uniqueness: true
end
