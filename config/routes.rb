Rails.application.routes.draw do
	root to: 'welcome#index'
	resources :landlords
	# get 'app', to: 'users#index'
	get 'app', to: 'landlords#index'
end
