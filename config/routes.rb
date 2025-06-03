# config/routes.rb
Rails.application.routes.draw do
  get "users/new"
  get "users/create"
  # set root to new home/landing page
  root "home#index"

  get "up" => "rails/health#show", as: :rails_health_check


  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new", as: "signup"

  resources :journal_entries, only: [ :index, :show ]
  resources :recipes, only: [ :index, :show ]
  resources :plantings, only: [ :index, :show, :new, :create, :edit, :update ]
  resources :users, only: [ :new, :create ]
end
