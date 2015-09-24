Rails.application.routes.draw do
	resources :attractions
	root "attractions#index"
end
