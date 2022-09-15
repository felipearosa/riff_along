Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/privacy-policy', to: 'pages#policy', as: 'policy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :videos
  resources :lists, except: [:index]

  resources :users do
    resources :videos, only: [:show]
  end
  resources :catalogs, only: [:create, :destroy]

  resources :solos, only: [:create, :update, :destroy]

end
