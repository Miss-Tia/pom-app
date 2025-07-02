Rails.application.routes.draw do
  root "home#index"

  get "up" => "rails/health#show", as: :rails_health_check

  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new", as: "signup"

  post "/generate_prompt", to: "prompts#generate"



  resources :users, only: [ :new, :create ]
  resources :dashboards, only: [ :show ]

  resources :journal_entries
  resources :recipes, only: [ :index, :show ]

  resources :gardens do
    resources :plantings, only: [ :index, :new, :create ]
  end

  resources :plants, only: [ :new, :create, :edit, :update, :destroy ]


  resources :plantings, only: [ :show, :edit, :update, :destroy ] do
    post :add_progress_note, on: :member
    post "/plantings/:id/add_progress_note", to: "plantings#add_progress_note", as: :add_progress_note_planting
  end
end
