Rails.application.routes.draw do
  root "pages#login"

  get "login", to: "pages#login", as: "login"
  get "about", to: "pages#about", as: "about"
  get "contact", to: "pages#contact", as: "contact"
  get "signup", to: "pages#signup", as: "signup"

  resources :users
  resources :posts
  resources :friend_requests

  devise_for :users
end
