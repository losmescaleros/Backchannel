Backchannel::Application.routes.draw do
  get "categories/new"

  get "categories/create"

  get "categories/edit"

  get "categories/update"

  get "categories/destroy"

  get "categories/show"

  get "categories/index"

  get "categories/approve"

  get "static_pages/home"

  get "static_pages/help"

  get "static_pages/about"

  # ~/ will take you to the static home page.
  root :controller => "static_pages", :action => "home"

  get "users/index"

  get "users/show"

  get "users/edit"

  get "users/new"

  get "users/create"

  get "users/destroy"

  get "users/update"

  get "users/promote"

  get "posts/index"

  get "posts/new"

  get "comments/show"

  get "comments/new"

  get "comments/edit"


  get "posts/:id/upvote" => "posts#upvote"
  get "posts/:id/unvote" => "posts#unvote"
  get "posts/:id/comment" => "comments#new"
  get "posts/:id/comment/create" => "comments#create"
  get "posts/:id/comment/update" => "comments#update"
  get "posts/:id/commentupvote" => "posts#commentupvote"
  get "posts/:id/commentunvote" => "posts#commentunvote"
  get "posts/:id/commentdelete" => "posts#deletecomment"

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :posts do
    resources :comments
  end
  resources :categories
  match '/register', to: 'users#new', via: 'get'
  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'
  match '/home', to: 'static_pages#home', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'


  get "account/register"

  get "account/login"

  get "account/logout"

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
  # match ':controller(/:action(/:id))(.:format)'
end
