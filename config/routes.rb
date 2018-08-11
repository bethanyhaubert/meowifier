Rails.application.routes.draw do
	root 'main#index'
	resources :main, only: [:index, :create, :show]
end
