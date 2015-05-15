Rails.application.routes.draw do
  # Welcome Controller
  get 'welcome/contact'
  get 'welcome/about'
  root to: 'welcome#index'
end
