Crowdscore::Application.routes.draw do
  resources :businesses

  devise_for :users

  root to: 'home#index'
end
