Rails.application.routes.draw do

  root "pages#home"

  get "pages/login", as: "login"
  get "pages/about", as: "about"
  get "pages/contact", as: "contact"
  get "pages/signup", as: "signup"

  get 'users/edit'
  get 'users/update'
  get 'users/show'
  get 'users/index'
  get 'users/destroy'

  resources :friend_requests
  devise_for :users
end
