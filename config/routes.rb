Rails.application.routes.draw do
  devise_for :users
  root to: 'challenges#index'

  resources :challenges
end
