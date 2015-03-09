Rails.application.routes.draw do
  resources :charges, only: [:new, :create]
  resources :wikis

  devise_for :users

  root to: 'welcome#index'
end
