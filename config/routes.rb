Crowdscore::Application.routes.draw do

  get "user_dashboard/show"
  match "dashboard" => "UserDashboard#show"
  match "sign_in" => redirect("/users/sign_in")
  match "sign_up" => redirect("/users/sign_up")

  # TODO: Remove these.. they probably aren't needed
  get "user_locks/new"

  get "user_locks/create"

  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks", :registrations => "registrations", :passwords => "passwords" }
  
  devise_scope :user do 
    get '/users/sign_out' => 'devise/sessions#destroy' 
    get "users/edit" => "devise/registrations#edit", :as => :edit_user_registration
  end

  resources :venue_tags, only: [:index]

  resources :users, only: [:show] do
    member do
      post :follow
      delete :unfollow
    end
  end
  
  resources :users do
    collection do
      post 'batch_invite'
    end
    post "/add_liked_cuisines" => "users#add_liked_venue_categories"
    post "/onboard_user" => "users#onboard_user"
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
        get :remove_vote
      end
    end
  end
  
  resources :venue_snapshots

  resources :venue_categories, :only => [] do
    resources :venue_subcategories, :only => :index
  end

  resources :lists do
    member do
      put :add
      put :remove
      get :upvote
      get :remove_vote
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
    resources :venue_categories
    resources :venue_subcategories
    resources :score_categories
    resources :featured_venues
    resources :featured_lists
    resources :venue_tags
    resources :venue_tag_categories
    resources :factual_crowdscore_maps#, :controller => :factual_crowdscore_maps, :as => :factual_crowdscore_maps
    root to: 'dashboards#show'
  end

  root to: 'home#index'
  
  #API Routes
  
  namespace :api, defaults: {format: 'json'} do
   	resources :venues, only: [ :index, :show ]
  end
  
  
end
