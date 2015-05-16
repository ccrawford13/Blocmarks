Rails.application.routes.draw do
  devise_for :users
  # Welcome Controller
  get 'welcome/contact'
  get 'welcome/about'
  root to: 'welcome#index'
end
