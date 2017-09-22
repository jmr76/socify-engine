Socify::Engine.routes.draw do

  resources :posts
  resources :comments, only: [:create, :destroy]

  devise_for :users, class_name: "Socify::User", module: :devise, controllers: { omniauth_callbacks: 'socify/users/omniauth_callbacks' }
  
  resources :users do
    member do
      get :friends
      get :followers
      get :deactivate
      get :mentionable
    end
  end
  

  resources :events do
    collection do
      get :calendar
    end
  end

  authenticated :user do
    root to: 'home#index', as: 'home'
  end
  unauthenticated :user do
    root 'home#front'
  end
  
  root 'home#front'

  match :follow, to: 'follows#create', as: :follow, via: :post
  match :unfollow, to: 'follows#destroy', as: :unfollow, via: :post
  match :like, to: 'likes#create', as: :like, via: :post
  match :unlike, to: 'likes#destroy', as: :unlike, via: :post
  match :find_friends, to: 'home#find_friends', as: :find_friends, via: :get
  match :about, to: 'home#about', as: :about, via: :get

end

