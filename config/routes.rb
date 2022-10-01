Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'posts#index'
  resources :users, only: :show do
    resource :follows, only: [:create, :destroy]
    get 'followees', to: 'follows#followees', as: 'followees'
    get 'followers', to: 'follows#followers', as: 'followers'
  end
  resources :profiles, only: [:new, :create, :edit, :update]
  resources :introductions, only: [:new, :create, :edit, :update, :destroy]
  resources :targets, only: [:index, :create]
  resources :posts do
    resources :explanations, only: [:new, :create, :edit, :update, :destroy]
    resources :comments, only: :create
    resource  :likes, only: [:create, :destroy]
  end
end
