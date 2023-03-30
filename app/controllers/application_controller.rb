class ApplicationController < ActionController::Base
	include JsonWebToken
	before_action :authenticate_customer, :authenticate_seller

	private
	def authenticate_customer
		header = request.headers["Authorization"]
		header = header.split(" ").last if header
		begin
			decoded = jwt_decode(header)
			@current_customer = Customer.find(decoded[:customer_id])
		rescue ActiveRecord::RecordNotFound => e
			render json: { error: e.message }, status: :unauthorized
		rescue JWT::DecodeError => e
			render json: { error: e.message }, status: :unauthorized
		end
	end
	def authenticate_seller
		header = request.headers["Authorization"]
		header = header.split(" ").last if header
		begin
			decoded = jwt_decode(header)
			@current_seller = Seller.find(decoded[:seller_id])
		rescue ActiveRecord::RecordNotFound => e
			render json: { error: e.message }, status: :unauthorized
		rescue JWT::DecodeError => e
			render json: { error: e.message }, status: :unauthorized
		end
	end
end
