class CartsController < ApplicationController
	skip_before_action :verify_authenticity_token, :authenticate_seller
	skip_before_action :authenticate_customer, except: %i[add_cart show_by_customer new edit update destroy]
	before_action :set_cart, only: %i[show edit update destroy]
	# GET /carts or /carts.json
	def index
		render json: Cart.includes(:customer).all
	end

	# GET /mycarts or /mycarts
	def show_by_customer
		if @current_customer.carts.present?
			render json: @current_customer.carts
		else
			render json: {message: "Your cart is empty"}
		end
	end

	# GET /carts/1 or /carts/1.json
	def show
		render json: @cart
	end

	# GET /carts/new
	def new
		@cart = @current_customer.carts.new
	end
	
	# GET /carts/1/edit
	def edit
	end

	#POST /products/1/carts or /products/1/carts.json
	def add_cart
		@product = Product.find(params[:id])
		unless @current_customer.carts&.find_by_product_id(params[:id])
			@cart = @current_customer.carts.new(product_id: @product.id, product_name: @product.product_name, description: @product.description, price: @product.offer_price)
			@cart.save
			render json: @cart, status: :created
		else
			@cart = @current_customer.carts.find_by_product_id(params[:id])
			@current_customer.carts.update(quantity: @cart.quantity+=1)
			render json: @cart, status: :ok
		end
	end

	# PATCH/PUT /carts/1 or /carts/1.json
	def update
		if @cart.update(cart_params)
			render json: @current_customer.carts, status: :ok
		else
			render json: { error: @cart.errors }, status: :unprocessable_entity
		end
	end
	
	# DELETE /carts/1 or /carts/1.json
	def destroy
		@cart.destroy
		render json: { message: "Your cart is deleted"}, statsu: :no_content
	end

	private
	def set_cart
		@cart = Cart.find(params[:id])
	end
	def cart_params
		params.permit(:quantity)
	end
end
