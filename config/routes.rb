Rails.application.routes.draw do

  get 'bookmarks/index'

  get 'topics/index'

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:show]

  post :incoming, to: "incoming#create"
  # Welcome Controller
  get 'welcome/contact'
  get 'welcome/about'
  root to: 'welcome#index'
end
