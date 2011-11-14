Inventory1::Application.routes.draw do

  get "ownerships/new"

  get "ownerships/edit"

  get "ownerships/destroy"

  get "ownerships/show"

  get "ownerships/index"

  get "ownerships/create"

  get "ownerships/update"

  resources :sessions, :only =>[:new, :create, :destroy]
  resources :statuses
  resources :categorys  
  resources :users 
  resources :items 

  match '/items/:id/remove', :to => 'items#remove'

# routing for static pages:    
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'
  match '/signin', :to => 'pages#signin'
  match '/signout', :to => 'sessions#destroy'

# routing for home page      
  root :to => 'pages#home'

end
