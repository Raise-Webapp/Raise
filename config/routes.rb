Rails.application.routes.draw do
  resources :ducts
  resources :duct_lines
  root 'duct_lines#index'
  get 'duct_form', to: 'ducts#form'
end