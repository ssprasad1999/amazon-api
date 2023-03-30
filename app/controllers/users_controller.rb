class UsersController < ApplicationController
	skip_before_action :authenticate_customer, :authenticate_seller
	def index
		render json: User.all, except: %i[created_at updated_at]
	end
	def self.create_user_as_seller(get)
		@user=User.new(email: get.seller_email, password: get.password_digest)
		if @user.save
			get.user_id=@user.id
		else
			render json: {error: @user.errors.full_messages.to_sentence}, status: :unprocessable_entity
		end
	end
	def self.create_user_as_customer(get)
		@user=User.new(email: get.email, password: get.password_digest)
		if @user.save
			get.user_id=@user.id
		else
			render json: {error: @user.errors.full_messages.to_sentence}, status: :unprocessable_entity
		end
	end
end
