Crowdscore::Application.routes.draw do
  devise_for :users
  resources :venues do
    resources :images, :controller => :venue_images, :as => :images, :only => [:new, :create]
  end

  resources :venue_categories, :only => [] do
    resources :venue_subcategories, :only => :index
  end

  namespace :admin do
    resources :users
    resources :venues
    namespace :venues do
      resource :import, :controller => :venue_imports, :as => :import, :only => [:new, :create]
    end
    root to: 'dashboards#show'
  end

  root to: 'home#index'
end
