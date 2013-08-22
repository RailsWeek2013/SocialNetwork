Socialnetwork::Application.routes.draw do
  resources :likes

  devise_for :users 

  root :to => "socialnetworks#index"
  delete 'deletepost' => 'socialnetworks#deletepost'
  get 'likepost' => 'socialnetworks#likepost'
  get 'commentpost/:p_id' => 'socialnetworks#commentpost', as: "commentpost"
  post 'addcomment' => 'socialnetworks#addcomment'
  delete 'deletecomment' => 'socialnetworks#deletecomment'



  get 'usersearch' => 'socialnetworks#usersearch'
  get "socialnetwork" => "socialnetworks#index"
  post 'createpost' => 'socialnetworks#createpost'

  get 'friend' => 'friend#friendhome'
  get 'friendadd' => 'friend#friendadd'
  get 'frienddelete' => 'friend#frienddelete'
  get 'friendaccept' => 'friend#friendaccept'
  get 'frienddenie' => 'friend#frienddenie'
  get 'friendprofile' => 'friend#friendprofile'
  get 'friendnewpin' => 'friend#friendnewpinentry'
  get 'frienddeletepin' => 'friend#frienddeletepinentry'

  get 'userprofile' => 'user#userprofile'
  patch 'edituser' => 'user#edituser'

  #get 'messages' => 'messages#index'
  get 'messagesnew' => 'messages#newmsg'
  post 'messagesavenewmsg' => 'messages#savenewmsg'
  get 'messageshowconversation/:id' => 'messages#showconversation', as: "showconversation"
 
  resources :users, only: [] do
    resources :messages, only: [:new, :create]
  end

  #get 'messages(/:id)/new' => 'messages#new', as: "new_message"
  resources :messages, except: [:new] do 
  end



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
