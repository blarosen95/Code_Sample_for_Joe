Rails.application.routes.draw do
	root to: 'welcome#index'
	resources :users
	get 'app', to: 'users#index'
end
