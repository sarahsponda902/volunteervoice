RMTest::Application.routes.draw do
  
  ##### SEARCHES
  match "searches/create" => "searches#create"
  
  match "searches/subject/:subject/create" => "searches#create"
  
  match "searches/:location/create" => "searches#create"
  
  resources :searches

  ##### FLAGS
  get "flags/thank_you"

  resources :mad_mimi_emails

  resources :contacts

  resources :flags

  resources :new_reviews

  root :to => 'pages#home'

  resources :feedbacks

  devise_for :admins
  
  devise_for :users, :controllers => {:registrations => :registrations}

  resources :favorites
  
  resources :ratings
  
  ##### UPDATE MESSAGES
  match "update_messages/:id/send_message" => "update_messages#send_message"
  match "update_messages/:id/send_message_preview" => "udate_messages#send_message_preview"

  
  ##### MESSAGES
  
  match "messages/:id/mark_deleted" => 'messages#mark_deleted'
  
  match "messages/:id/mark_sent_deleted" => 'messages#mark_sent_deleted'

  match "users/send_message/:id" => 'users#send_message'
  
  match "users/send_message.:id" => 'users#send_message'
  
  match "messages/:recipient_id/create" => 'messages#new'
  
  match "messages/:id/delete" => 'messages#destroy'
  
  match "/profile_messages_sent" => 'pages#profile_messages_sent'
  
  ##### FAVORITES
  
  match "favorites/:program_id/create" => 'favorites#create'
  
  match "favorites/:id/destroy/:field/:location" => 'favorites#destroy'
  
  match "programs/favorites/:id/edit" => 'favorites#edit'
  
  ##### NEW REVIEWS
  
  match "new_reviews/:id/changeShow" => 'new_reviews#changeShow'
  
  ##### REVIEWS
  
  match "reviews/:id/changeFlagShow" => "reviews#changeFlagShow"
  
  match "reviews/:id/changeShow" => 'reviews#changeShow'
  
  match "reviews/:user_id/create" => 'reviews#new'
  
  match "reviews/:id/destroy/:field/:location" => 'reviews#destroy'
  
  match "reviews/:id/destroy/:field/" => 'reviews#destroy'
  
  match 'reviews/new.:id' => 'reviews#new'
  
  match "programs/:organization_id/:program_id/new" => 'reviews#new'
  
  match "reviews/:id/edit" => 'reviews#edit'
  
  match "organizations/:organization_id/new" => 'reviews#new'
  
  match "reviews/reviewNew" => 'reviews#reviewNew'
  
  match "reviews/already_reviewed" => 'reviews#already_reviewed'
  
  ##### FEEDBACKS
  
  match "feedbacks/:id/changeShow" => 'feedbacks#changeShow'
  
  ##### USERS
  
  match 'users/:id/crop' => 'users#crop'
  
  match 'users.:id' => 'users#show'
  
  devise_scope :user do
  
    match 'sign_up' => 'devise/registrations#new'
    
    match 'unlock' => 'devise/unlocks#new'
  
    match 'sign_in' => 'devise/sessions#new'
  
    match 'signout' => 'devise/sessions#destroy'
    
    match "registrations/thank_you" => 'registrations#thank_you'
    
    match "registrations/mustBe" => 'registrations#mustBe'
    
    match "registrations/email_confirm" => 'registrations#email_confirm'
    
    match "registrations/are_you_sure" => 'registrations#are_you_sure'
    
    match "confirmations/new" => 'devise/confirmations#new'
    
    match "confirmations/:confirmation_token" => 'devise/confirmations#show'
    
    match "unlocks/:unlock_token" => 'devise/unlocks#unlock_account'
    
    match "passwords/:reset_password_token" => 'devise/passwords#edit'
  
  end
  
  match "users/check_email" => 'users#check_email'

  match "users/check_username" => 'users#check_username'
  
  match "users/:id/crop" => 'users#crop'
  
  match "users/:id/update_crop" => 'users#update_crop'
  
  match "registrations/:id/crop" => 'registrations#crop'
  
  match "registrations/crop" => 'registrations#crop'
  
  devise_scope :admin do
    match 'admins/new' => 'admins/registrations#new'
    match 'admin_login' => 'devise/sessions#new'
    match 'signout' => 'devise/sessions#destroy'
  end

  ##### MAD MIMI
  
  match "mad_mimi_email/new" => 'mad_mimi_email#new'

  
  ##### PAGES
  
  match "pages/profile/sent_deleted" => "pages#profile"
  
  match "pages/profile/message_deleted" => "pages#profile"
  
  match "pages/profile/favorite_deleted" => "pages#profile"
  
  get "pages/test"
  
  get "pages/home"
  
  get "pages/profile" 
  
  get "pages/profile_messages"
  
  get "pages/profile_messages_sent"
  
  get "pages/profile_favorites"
  
  get "pages/blogs"
  
  get "pages/about_form"
  
  get "searches/show"
  
  get "searches/index"
  
  get "pages/search_machine"
  
  get "pages/get_info"
  
  get "pages/searches"
  
  get "pages/search_machine_results"
  
  get "pages/program_browse"
  
  get "pages/program_browse_results"
  
  get "pages/sorted_results"
  
  get "pages/organization_sorted"
  
  get "pages/thank_you"

  
  get "pages/about"
  get "pages/contact"
  get "pages/terms"
  get "pages/privacy"
  get "pages/faq"
  get "pages/thank_you_review"
  get "pages/thank_you_new_review"
  
  match "searches/:region/program_search" => 'searches#program_search'

  
  ###### PROGRAMS
  
  match 'programs/:id/crop' => 'programs#crop'
  
  
  
  ###### ORGANIZATIONS
  
  match 'organizations/:id/crop' => 'organizations#crop'
  
  match "organizations/:id/edit" => 'organizations#edit'
  
  match "organizations/pages/get_info" => 'pages#get_info'
  
  match "organizations/:id/programs" => 'organizations#programs'
  
  get "organizations/program_contents"
  
  ########## BLOG
  
  match "blog_posts/:id/destroy/:location" => 'blog_posts#destroy'
  
  match "pages/blog_posts" => 'blog_posts#index'
  
  match "pages/blog_search" => 'pages#blog_search'
  
  match "blog_posts/:id/crop" => 'blog_posts#crop'
  
  match "blog_posts/:id/square" => 'blog_posts#square'
  
  resources :blog_posts do
		resources :blog_comments
		resources :blog_images
		
		collection do
			get :drafts
		end
		
		member do
			get :tag
			get :photo
		end
	end
	
  
  ########## RESOURCES

  resources :messages
  
  resources :programs do
  	resources :reviews
  	post :create_review, :on => :collection
  	end

  resources :reviews
  
  resources :users do 
    post :send_message, :on => :collection
    collection do
      get 'checkname'
    end
  end
  
  resources :organizations
  
  ########## ROOT
  
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
  # match ':controller(/:action(/:id))(.:format)'
  
end