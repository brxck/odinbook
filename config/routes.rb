Rails.application.routes.draw do
  root "pages#login"

  # Hijack devise authenticate_user! redirect to prevent 401.
  get "users/sign_in", to: "pages#login"

  # Unauthenticated pages
  get "login", to: "pages#login", as: "login"
  get "about", to: "pages#about", as: "about"
  get "contact", to: "pages#contact", as: "contact"
  get "signup", to: "pages#signup", as: "signup"

  # Authenticated pages
  get "home", to: "pages#home", as: "home"

  resources :users
  resources :friends, only: %i[index destroy]
  resources :friend_requests, except: %i[edit]
  resources :posts
  resources :reactions, only: %i[create]
  resources :notifications, only: %i[destroy]

  devise_for :users
end
