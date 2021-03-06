Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'posts#index'

  devise_for :admins

  resources :galleries, path: 'my-works'
  resources :posts do
    get 'page/:page', :action => :index, :on => :collection, as: :paginate
  end

  # Attachment: image, document and so on.
  namespace :attachment do
    get 'image/:fid' => 'image#original', as: :image_original
    get 'image/edit/:fid' => 'image#edit', as: :image_edit
    patch 'image/:fid' => 'image#update', as: :image
    get 'image/:fid/preview' => 'image#preview', as: :image_preview
    post 'image/download' => 'image#download', as: :image_download
    post 'image/destroy' => 'image#destroy', as: :image_destroy
  end

  #get 'contacts' => 'dashboard#contacts'

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
