Rails.application.routes.draw do
  get "users/index"

  get "up" => "rails/health#show", as: :rails_health_check

  root "main#index"

  get "/about-us", to: "main#about", as: :about

  resources :users do
    resource :password, only: [ :edit, :update ]
  end
  resources :password_resets, only: [ :new, :create, :edit, :update ]

  get    "/auth/twitter/callback", to: "sessions#omniauth"
  get    "/auth/failure",          to: "sessions#failure"

  # Signup
  get  "/sign_up", to: "registrations#new", as: :sign_up
  post "/sign_up", to: "registrations#create"

  # Login
  get  "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"

  # Logout
  delete "/logout", to: "sessions#destroy", as: :logout
end
