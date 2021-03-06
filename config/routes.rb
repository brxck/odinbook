Rails.application.routes.draw do
  root to: redirect("/login")

  devise_for :users do
    delete "/logout" => "devise/sessions#destroy", :as => :destroy_user_session
  end

  # Hijack devise authenticate_user! redirect to prevent 401.
  get "users/sign_in", to: "pages#login"

  # Unauthenticated pages
  get "login", to: "pages#login", as: "login"
  get "about", to: "pages#about", as: "about"
  get "contact", to: "pages#contact", as: "contact"
  get "signup", to: "pages#signup", as: "signup"

  # Authenticated pages
  get "home", to: "pages#home", as: "home"
  get "search", to: "pages#search", as: "search"

  resources :users
  resources :friends, only: %i[index destroy]
  resources :friend_requests, except: %i[edit new]
  resources :posts
  resources :comments, only: %i[create]
  resources :reactions, only: %i[create]
  resources :notifications, only: %i[destroy]
end
