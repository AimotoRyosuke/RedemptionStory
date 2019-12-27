Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: 'posts#index'
  resources :posts do
    resources :images, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy],  defaults: { format: 'json' }
  end
  resources :users do
    collection do
      get 'select', to: 'users#select'
    end
  end
end