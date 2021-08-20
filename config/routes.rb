Rails.application.routes.draw do
	root to: 'welcome#index'
	resources :patients
	# get 'app', to: 'users#index'
	get 'app', to: 'patients#index'
end
