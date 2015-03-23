Rails.application.routes.draw do
  resources :charges, only: [:create]
  resources :wikis do
    resources :collaborations
  end


  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  root to: 'welcome#index'
end
