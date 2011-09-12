Crowdscore::Application.routes.draw do
  devise_for :users
  resources :venues

  namespace :admin do
    root to: 'dashboards#show'
  end

  root to: 'home#index'
end
