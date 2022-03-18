Rails.application.routes.draw do
	get "/zip-codes", to: "zipcodes#index"
	get "/zip-codes/:id", to: "zipcodes#show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
