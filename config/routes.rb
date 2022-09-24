Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'posts#index'
  resources :users, only: :show
  resources :profiles, only: [:new, :create]
  resources :targets, only: [:index, :create]
  resources :posts, only: [:index, :new, :create, :show]
end
