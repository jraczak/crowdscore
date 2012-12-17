Crowdscore::Application.routes.draw do
  # TODO: Remove these.. they probably aren't needed
  get "user_locks/new"

  get "user_locks/create"

  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :venue_tags, only: [:index]

  resources :users, only: [:show] do
    member do
      post :follow
      delete :unfollow
    end
  end

  resources :venues do
    collection do
      get :search
    end

    resources :tags, :controller => :venue_tags, :as => :tags, :only => [:index, :create]
    resources :images, :controller => :venue_images, :as => :images, :only => [:new, :create]

    resource :score, controller: :venue_scores, as: :score, only: [:new, :create]
    resources(:tips, only: [:index, :new, :create]) do
      member do
        get :upvote
      end
    end
  end

  resources :venue_categories, :only => [] do
    resources :venue_subcategories, :only => :index
  end

  resources :lists do
    member do
      put :add
      put :remove
    end
  end

  namespace :admin do
    resources :users do
      resource :lock, :controller => :user_locks, :as => :lock, :only => [:new, :create, :destroy]
    end
    resources :venues
    namespace :venues do
      resource :import, :controller => :venue_imports, :as => :import, :only => [:new, :create]
    end
    root to: 'dashboards#show'
  end

  root to: 'home#index'
end
