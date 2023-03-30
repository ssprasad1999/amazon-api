class SellersController < ApplicationController
	skip_before_action :verify_authenticity_token, :authenticate_customer
	skip_before_action :authenticate_seller, except: %i[update edit destroy]
	before_action :set_seller, only: %i[show edit update destroy]
	# GET /sellers or /sellers.json
	def index
		render json: Seller.includes(:products).all, each_serializer: SellerSerializer
	end

	# GET /sellers/new
  def new
    @seller = Seller.new
  end

  # GET /sellers/1/edit
  def edit
  end

	# GET /sellers/1 or /sellers/1.json
	def show
		render json: @seller
	end

	# POST /bussiness/signup or /bussiness/signup.json
	def bussiness_signup
		@seller = Seller.new(seller_params)
		UsersController.create_user_as_seller(@seller)
		if @seller.save
			render json: { message: "Welcome #{@seller.seller_name} you are successfully registered for amazon_bussiness" }, status: :created
		else
			render json: { error: @seller.errors }, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /sellers/1 or /sellers/1.json
	def update
		if @seller.update(seller_params)
			render json: { message: "#{@seller.name} your profile is successfully updated"}, status: :ok
		else
			render json: { error: @seller.errors }, status: :unprocessable_entity
		end
	end
	
	# DELETE /sellers/1 or /sellers/1.json
	def destroy
		@seller.destroy
		render json: { message: "Your account has been deleted"}, statsu: :no_content
	end

	private
	def set_seller
		@seller= Seller.find(params[:id])
	end
	def seller_params
		params.permit(:seller_email, :seller_name, :password, :store_name, :seller_address)
	end
end