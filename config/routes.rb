Rails.application.routes.draw do
  root "pages#home"

  get "pages/home"

  get "pages/about"

  get "pages/contact"

  root "devise/sessions#new"

  resources :friend_requests
  devise_for :users
end
