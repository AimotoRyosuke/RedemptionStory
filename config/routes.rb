Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: 'posts#index'
  resources :posts do
    collection do
      get 'rakuten', to: 'posts#rakuten_search', defaults: { format: 'json' }
    end
    resources :likes, only: [:create, :destroy], defaults: { format: 'json' }
    resources :comments, only: [:create, :destroy], defaults: { format: 'json' }
  end
  resources :users, only: [:show] do
    collection do
      get 'menu', to: 'users#signup_menu'
    end
  end
end