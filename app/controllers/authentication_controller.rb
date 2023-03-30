class AuthenticationController < ApplicationController
	skip_before_action :verify_authenticity_token, :authenticate_customer, :authenticate_seller

	# POST auth/signin
	def signin
		@customer = Customer.find_by_email(params[:email])
		@seller = Seller.find_by_seller_email(params[:email])
		if @customer && @customer.authenticate(params[:password])
			token = jwt_encode(customer_id: @customer.id)
			render json: {token: token}, status: :ok
		elsif @seller && @seller.authenticate(params[:password])
			token = jwt_encode(seller_id: @seller.id)
			render json: {token: token}, status: :ok
		else
			render json: {error: "Invalid Credentials"}, status: :unauthorized
		end
	end
end
