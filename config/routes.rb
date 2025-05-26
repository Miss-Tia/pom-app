# config/routes.rb
Rails.application.routes.draw do
  get "plantings/index"
  get "plantings/show"
  get "journal_entries/index"
  get "journal_entries/show"

  get "up" => "rails/health#show", as: :rails_health_check
  root "plantings#index"

  resources :journal_entries, only: [ :index, :show ]
  resources :recipes, only: [ :index, :show ]
  resources :plantings, only: [ :index, :show, :new, :create, :edit, :update ]
end
