class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :mobile_number, :date_of_birth, :gender, :address
	has_many :carts
end
