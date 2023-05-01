Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               registrations: 'registrations',
             }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users, only: %i[show update]

  get '/settings/profile', to: 'settings/profile#show'
  get '/settings/keys', to: 'settings/keys#show'

  get '/records/introduction/new', as: 'new_introduction'
  post '/records/introduction', to: 'records/introduction#create', as: 'create_introduction'
  post '/records/signature', to: 'records/signature#create', as: 'sign_record'

  root 'home#index'
end
