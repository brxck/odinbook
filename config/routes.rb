Rails.application.routes.draw do
  root "pages#login"

  # Hijack devise authenticate_user! redirect to prevent 401.
  get "users/sign_in", to: "pages#login"

  get "login", to: "pages#login", as: "login"
  get "about", to: "pages#about", as: "about"
  get "contact", to: "pages#contact", as: "contact"
  get "signup", to: "pages#signup", as: "signup"

  resources :users
  resources :posts
  resources :friend_requests
  resources :reactions, only: %i[create]

  devise_for :users
end
