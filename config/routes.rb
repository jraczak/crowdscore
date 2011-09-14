Crowdscore::Application.routes.draw do
  devise_for :users
  resources :venues

  namespace :admin do
    resources :users
    root to: 'dashboards#show'
  end

  root to: 'home#index'
end
