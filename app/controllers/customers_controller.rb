class CustomersController < ApplicationController
	skip_before_action :verify_authenticity_token, :authenticate_seller
	skip_before_action :authenticate_customer, except: %i[update edit destroy]
	before_action :set_customer, only: %i[show edit update destroy]
	# GET /customers or /customers.json
	def index
		render json: Customer.includes(:carts).all, each_serializer: CustomerSerializer
	end
	
	# GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

	# GET /customers/1 or /customers/1.json
	def show
		render json: @customer
	end
	
	# POST /signup or /signup.json
	def signup
		@customer = Customer.new(customer_params)
		UsersController.create_user_as_customer(@customer)
		if @customer.save
			render json: { message: "Welcome #{@customer.name} you are successfully registered for amazon" }, status: :created
		else
			render json: { error: @customer.errors }, status: :unprocessable_entity
		end
	end
	
	# PATCH/PUT /customers/1 or /customers/1.json
	def update
		if @customer.update(customer_params)
			render json: { message: "#{@customer.name} your profile is successfully updated"}, status: :ok
		else
			render json: { error: @customer.errors }, status: :unprocessable_entity
		end
	end
	
	# DELETE /customers/1 or /customers/1.json
	def destroy
		@customer.destroy
		render json: { message: "Your account has been deleted"}, statsu: :no_content
	end

	private
	def set_customer
		@customer = Customer.find(params[:id])
	end
	def customer_params
		params.permit(:name, :email, :password, :mobile_number, :date_of_birth, :gender, :address)
	end
end
