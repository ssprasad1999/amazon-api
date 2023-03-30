class ProductsController < ApplicationController
	skip_before_action :verify_authenticity_token, :authenticate_customer
	skip_before_action :authenticate_seller, except: %i[create show_by_seller new edit update destroy]
	before_action :set_product, only: %i[show edit update destroy]
	# GET /products or /products.json
	def index
		render json: Product.includes(:seller).all, each_serializer: ProductSerializer
	end

	# GET /products/new
  def new
    @product = @current_seller.products.new
  end

  # GET /products/1/edit
  def edit
  end

	# GET /products/1 or /products/1.json
	def show
		render json: @product
	end

	# GET /myproducts or /myproducts.json
	def show_by_seller
		render json: @current_seller.products
	end

	# GET /products%20in/mobiles or /products%20in/mobiles.json
	# GET /products%20in/redmi or /products%20in/redmi.json
	def show_brand_category
		@product = Product.where(brand: params[:brand_category])
		@product = Product.where(category: params[:brand_category]) if @product.empty?
		render json: @product, except: %i[id created_at updated_at] unless @product.empty?
		render json: {error: "Sorry No product found for the given input"}, status: :not_found if @product.empty?
	end

	# GET /products%20in/redmi/mobiles or /products%20in/redmi/mobiles.json
	# GET /products%20in/watches/mens or /products%20in/watches/mens.json
	def show_brand_in_category_in_consumer
		@product = Product.where(brand: params[:brand_category], category: params[:category_consumer])
		@product = Product.where(category: params[:brand_category], consumer_type: params[:category_consumer]) if @product.empty?
		render json: @product, except: %i[id created_at updated_at] unless @product.empty?
		render json: {error: "Sorry No product found for the given input"}, status: :not_found if @product.empty?
	end

	# GET /products%20in/fastrack/watches/mens or /products%20in/fastrack/watches/mens.json
	def show_brand_in_category_for_consumer
		@product = Product.where(brand: params[:brand], category: params[:category], consumer_type: params[:consumer])
		render json: @product, except: %i[id created_at updated_at] unless @product.empty?
		render json: {error: "Sorry No product found for the given input"}, status: :not_found if @product.empty?
	end

	# POST /products or /products.json
	def create
		@product = @current_seller.products.new(product_params)
		if @product.save
			render json: { message: "Your product is added successfully to amazon" }, status: :created
		else
			render json: { error: @product.errors }, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /products/1 or /products/1.json
	def update
		if @product.update(product_params)
			render json: { message: "Your product is updated successfully"}, status: :ok
		else
			render json: { error: @product.errors }, status: :unprocessable_entity
		end
	end
	
	# DELETE /products/1 or /products/1.json
	def destroy
		@product.destroy
		render json: { message: "Your product has been deleted"}, statsu: :no_content
	end

	private
	def set_product
		@product = Product.find(params[:id])
	end
	def product_params
		params.permit(:product_name, :brand, :actual_price, :offer, :description, :category, :consumer_type)
	end
end
