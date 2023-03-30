Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
	resources :products
	get "products in/:brand_category", to: "products#show_brand_category"
	get "products in/:brand_category/:category_consumer", to: "products#show_brand_in_category_in_consumer"
	get "products in/:brand/:category/:consumer", to: "products#show_brand_in_category_for_consumer"
	get "myproducts", to: "products#show_by_seller"
	resources :customers
	post "signup", to: "customers#signup"
	resources :sellers
	post "bussiness/signup", to: "sellers#bussiness_signup"
	resources :users
	post "/auth/signin", to: "authentication#signin"
	resources :carts
	post "/products/:id/carts", to: "carts#add_cart"
	get "/mycarts", to: "carts#show_by_customer"
end
