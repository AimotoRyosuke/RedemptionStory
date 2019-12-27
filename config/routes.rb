Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :posts do
    resources :images, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy],  defaults: { format: 'json' }
  end
end