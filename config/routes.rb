Inventory1::Application.routes.draw do
   

#  get "sessions/new"
#  get "sessions/create"
#  get "sessions/destroy"
  
  resources :sessions, :only =>[:new, :create, :destroy]
	
  get "statuses/new"
  get "statuses/edit"
  get "statuses/destroy"
  get "statuses/show"
  get "statuses/index"
  get "statuses/create"
  get "statuses/update"

  get "categorys/new"
  get "categorys/edit"
  get "categorys/destroy"
  get "categorys/show"
  get "categorys/index"
  get "categorys/create"
  get "categorys/update"

#  get "users/new"
#  get "users/edit"
#  get "users/destroy"
#  get "users/show"
#  get "users/index"
#  get "users/create"
#  get "users/update"

  resources :users 
   
#  get "items/new"
#  get "items/edit"
#  get "items/destroy"
#  get "items/show"
#  get "items/index"
#  get "items/create"
#  get "items/update"

   resources :items 
   match '/items/:id/remove', :to => 'items#remove'

   match '/contact', :to => 'pages#contact'
   match '/about', :to => 'pages#about'
   match '/help', :to => 'pages#help'
   match '/signin', :to => 'pages#signin'
   match '/signup', :to => 'pages#signup'
     
   root :to => 'pages#home'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
