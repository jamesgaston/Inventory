Inventory1::Application.routes.draw do
  
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

# routing for home page      
  root :to => 'pages#home'

end
