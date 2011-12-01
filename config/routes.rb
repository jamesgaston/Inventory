Inventory1::Application.routes.draw do
 
  
 		# we don't need session#index nor any session_id 
  		# so use the singular "resource"
  resource :sessions, :only =>[:new, :create, :destroy]

  resources :users 
  resources :items 
  resources :ownerships 
  resources :categories  
  resources :provinces  
  resources :countries  
  resources :messages 

		# routing for static pages   
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/signup', :to => 'users#new', :as => 'signup' 
  match '/admin', :to => 'users#useradmin', :as => "admin" 
  
		# routing for home page      
  root :to => 'pages#home'

end
