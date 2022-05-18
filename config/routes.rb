Rails.application.routes.draw do
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: [:index, :show, :update], shallow: true

  get '/records/introduction/new', as: 'new_introduction'
  post '/records/introduction', to: 'records/introduction#create', as: 'create_introduction'
  post '/records/signature', to: 'records/signature#create', as: 'sign_record'

  # Defines the root path route ("/")
  root "home#index"
end
