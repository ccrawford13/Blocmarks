Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  
  resources :users, only: [:show] do
    resources :bookmarks, only: [:index]
  end

  resources :topics, only: [:index, :create]

  resources :topics, except: [:index, :create] do
    resources :bookmarks, only: [:index, :create], shallow: true
  end

  # Incoming Mail Controller
  post :incoming, to: "incoming#create"
  # Welcome Controller
  get 'welcome/contact'
  get 'welcome/about'
  root to: 'welcome#index'
end
