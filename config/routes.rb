Rails.application.routes.draw do
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users

  resources :users, only: [:index, :show, :update], shallow: true
  resources :records, only: :create

  # Defines the root path route ("/")
  root "home#index"
end
