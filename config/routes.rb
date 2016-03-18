Rails.application.routes.draw do
  resources :messages, except: [:edit, :update]
  root to: 'messages#index'

  resources :users, only: [:index, :show] do
    collection do
      resource :registrations, only: [:new, :create]
      resource :sessions,      only: [:new, :create, :destroy]
    end
    member do
      put :follow
      put :unfollow
    end
    resources :messages, only: [:index]
    resources :followeds, controller: :users, collection: 'followeds', only: [:index]
    resources :followers, controller: :users, collection: 'followers', only: [:index]
  end

  namespace 'api' do
    scope module: 'v1' do
      resources :users, only: [:index, :show] do
        resources :followeds, controller: :users, collection: 'followeds', only: [:index]
        resources :followers, controller: :users, collection: 'followers', only: [:index]
        resources :messages, only: [:index]
      end
      resources :messages, only: [:show]
    end
  end

  get  'sign_up', to: 'registrations#new',    as: :sign_up
  post 'sign_up', to: 'registrations#create', as: :do_user_sign_up
  get  'sign_in', to: 'sessions#new',         as: :sign_in

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
