Rails.application.routes.draw do

  resources :charges, only: [:create]
  resources :wikis do
    resources :collaborations, only: [:create, :new, :destroy]
  end


  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  root to: 'welcome#index'
end
