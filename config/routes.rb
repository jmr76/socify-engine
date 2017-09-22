Socify::Engine.routes.draw do

  resources :posts
  resources :comments, only: [:create, :destroy]

  devise_for :users, class_name: "Socify::User", module: :devise, controllers: { omniauth_callbacks: 'socify/users/omniauth_callbacks' }

  devise_scope :user do
    # Had to add routes for callbacks here because otherwise the routes get
    # messed up -- prepending an extra "/my_engine" in one case.
    providers = Regexp.union(Devise.omniauth_providers.map(&:to_s))
  
    path_prefix = '/users/auth'
  
    match "#{path_prefix}/:provider",
      :constraints => { :provider => providers },
      :to => "omniauth_callbacks#passthru",
      :as => :user_omniauth_authorize,
      :via => [:get, :post]
  
    match "#{path_prefix}/:action/callback",
      :constraints => { :action => providers },
      :to => 'omniauth_callbacks',
      :as => :user_omniauth_callback,
      :via => [:get, :post]
  end
  
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

