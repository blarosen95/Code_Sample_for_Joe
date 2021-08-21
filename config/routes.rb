Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :landlords
  get 'app', to: 'landlords#index'
  resources :rooms
end
