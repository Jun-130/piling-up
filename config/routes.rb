Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'posts#index'
  resources :users, only: :show
  resources :profiles, only: [:new, :create, :edit, :update]
  resources :targets, only: [:index, :create]
  resources :posts, only: [:index, :new, :create, :show, :edit, :update]
end
