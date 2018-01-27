Rails.application.routes.draw do

  root "pages#home"

  get "pages/login", as: "login"
  get "pages/about", as: "about"
  get "pages/contact", as: "contact"
  get "pages/signup", as: "signup"

  resources :users
  resources :posts
  resources :friend_requests

  devise_for :users
end
