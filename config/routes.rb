Rails.application.routes.draw do
	get  "/users/login", to: "login#new"
    post "/users/login", to: "login#create"
    delete "/users/login", to: "login#destroy"
	resources :users ##only: [:new, :create, :update, :destroy]
	resources :attractions
	root "attractions#index"


end
