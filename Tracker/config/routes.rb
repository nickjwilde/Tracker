Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

 #jquery handler methods
  match 'homes/', :to => 'jquery#homes', via: 'post'
  match 'order_details/', :to => 'jquery#order', via: 'post'
  match 'update_order/', :to => 'jquery#updateorder', via: 'post'
  match 'addnew/addevent/', :to => 'jquery#addevent', via: 'post'
  match 'addnew/addphotographer/', :to => 'jquery#addphotographer', via: 'post'
  match 'addnew/addproject/', :to => 'jquery#addproject', via: 'post'
  match 'parade_notes', :to => 'jquery#paradenotes', via: 'post'
  match 'home_notes', :to => 'jquery#homenotes', via: 'post'
  match 'update_parade_notes', :to => 'jquery#updateparadenotes', via: 'post'
  match 'update_home_notes', :to => 'jquery#updatehomenotes', via: 'post'

  root 'admin#events'
  get 'addnew/', to: 'admin#addnew'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
