Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :landlords
  get 'app', to: 'landlords#index'
  resources :rooms do
    get :index_by_landlord, on: :member
  end
end
