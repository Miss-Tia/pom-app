Rails.application.routes.draw do
<<<<<<< HEAD
  get "plantings/index"
  get "plantings/show"
  get "journal_entries/index"
  get "journal_entries/show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
=======
  root "home#index"
>>>>>>> b8467df9d29c21905f86a06c2840c65424c9a880

  get "up" => "rails/health#show", as: :rails_health_check

  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new", as: "signup"

<<<<<<< HEAD
  # Defines the root path route ("/")
  # root "posts#index"
  resources :journal_entries, only: [ :index, :show ]
  resources :recipes, only: [ :index, :show ]
  resources :plantings, only: [ :index, :show ]
=======
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
>>>>>>> b8467df9d29c21905f86a06c2840c65424c9a880
end
