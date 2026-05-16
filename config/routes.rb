Rails.application.routes.draw do
  get "users/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  root "main#index"

  get "/about-us", to: "main#about", as: :about

  resources :users do
  resource :password, only: [ :edit, :update ]
  end
  resources :password_resets, only: [ :new, :create, :edit, :update ]
  # Signup
  get  "/sign_up", to: "registrations#new", as: :sign_up
  post "/sign_up", to: "registrations#create"

  # Login
  get  "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"

  # Logout
  delete "/logout", to: "sessions#destroy", as: :logout
end
