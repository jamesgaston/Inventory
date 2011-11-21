Inventory1::Application.routes.draw do
  
  get "categories/show"

  get "categories/edit"

  get "categories/new"

  get "categories/create"

  get "categories/update"

  get "categories/delete"

  get "categories/index"

  get "provinces/show"

  get "provinces/edit"

  get "provinces/new"

  get "provinces/create"

  get "provinces/update"

  get "provinces/delete"

  get "provinces/index"

  resources :ownerships 
  resources :sessions, :only =>[:new, :create, :destroy]
  resources :categories  
  resources :provinces  
  resources :countries  
  resources :users 
  resources :items 

# routing for static pages:    
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  
  match '/admin', :to => 'users#useradmin', :as => "admin" 
  
# routing for home page      
  root :to => 'pages#home'

end
