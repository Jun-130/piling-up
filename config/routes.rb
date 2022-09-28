Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'posts#index'
  resources :users, only: :show
  resources :profiles, only: [:new, :create, :edit, :update]
  resources :introductions, only: [:new, :create, :edit, :update, :destroy]
  resources :targets, only: [:index, :create]
  resources :posts do
    resources :explanations, only: [:new, :create, :edit, :update, :destroy]
  end
end
