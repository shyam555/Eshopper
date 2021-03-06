Rails.application.routes.draw do
  
  get 'reports/index'
  get 'reports/sales_report'
  get 'reports/customer_registered'
  get 'reports/coupon_used'
  resources :recommended_products
  resources :contacts
  resources :wishlists
  resources :transactions
  resources :orders do
    member do
      get 'cancel_order'
    end
  end
  resources :coupons
  resources :addresses
  resources :checkouts  
  get :payment_review, to: 'checkouts#payment_review'
  get :check_coupon_code, to: 'checkouts#check_coupon_code'
  resources :cart_items
  resources :product_categories
  resources :products
  resources :brand_categories
  resources :charges do
    member do
      get 'payment'
    end
  end
  resources :products
  resources :categories do
    resources :brands
  end
  resources :brands
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get '*abc', :to => 'home#routing_error'
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
