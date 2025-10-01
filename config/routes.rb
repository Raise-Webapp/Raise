Rails.application.routes.draw do
  resources :ducts
  resources :duct_lines
  root 'duct_lines#index'

  get 'duct_form', to: 'ducts#form'
  
  get '/login', to: 'users#new'
  post '/login', to: 'users#create'
  delete '/logout', to: 'users#destroy'

end
