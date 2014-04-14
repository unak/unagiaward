Rails.application.routes.draw do
  get 'sessions/create'
  get 'sessions/destroy'

  match via: :get, '/auth/:provider/callback' => 'sessions#create'

  scope '/:locale' do
    get 'top/index'
    get '/signout', to: 'sessions#destroy'
    get 'nominates/list'
    resources :nominates

    root 'top#index'
  end

  match via: :get, '/' => redirect{|params, req|
    if req.headers["accept-language"]
      req.headers["accept-language"].split(/, */).map{|lang| lang.sub(/(?:-.*)?(?:;.*)?\z/, '')}.find{|lang|
        %w(ja en).include?(lang)
      } || '/en'
    else
      '/en'
    end
  }

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
