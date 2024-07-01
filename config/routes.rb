Rails.application.routes.draw do
  devise_for :users
  resources :friends
  root 'home#index'
  get 'home/about', to: 'home#about'
end
