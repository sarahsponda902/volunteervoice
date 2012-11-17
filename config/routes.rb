RMTest::Application.routes.draw do

  
  ###### MESSAGES
  
  match "messages/:id/mark_deleted" => 'messages#mark_deleted'
  
  match "messages/:id/mark_sent_deleted" => 'messages#mark_sent_deleted'

  match "users/send_message/:id" => 'users#send_message'
  
  match "users/send_message.:id" => 'users#send_message'
  
  match "messages/:recipient_id/create" => 'messages#new'
  
  match "messages/:id/delete" => 'messages#destroy'
  
  
  ###### ORGANIZATION ACCOUNTS
  
  get "organization_accounts/thank_you_request"
  
  get 'organization_accounts/successful_unsubscribe'
  
  match "organization_accounts/new_request" => 'organization_accounts#new_request'
  
  match 'organization_accounts/:id/change_subscription' => 'organization_accounts#change_subscription'
  
  
  ###### ERRORS

  get "errors/error_404"

  get "errors/error_500"
  

  ###### SEARCHES
  
  get "searches/program_browse"
  
  get "searches/places"
  
  get "searches/search_machine"
  
  get "searches/error"
  
  match "searches/:subject/program_browse_search" => "searches#program_browse_search"
  
  match "/searches/erase_old" => "searches#erase_old"
  
  match "searches/create" => "searches#create"
  
  match "searches/subject/:subject/create" => "searches#create"
  
  match "searches/:location/create" => "searches#create"

  ##### FLAGS
  get "flags/thank_you"
  
  ##### CONTACTS
  
  get "/contacts/thank_you"
  
  
  ##### FAVORITES
  
  match "favorites/:program_id/create" => 'favorites#create'
  
  match "favorites/:id/destroy/:field/:location" => 'favorites#destroy'
  
  match "programs/favorites/:id/edit" => 'favorites#edit'
  
  ##### NEW REVIEWS
  
  get "/new_reviews/thank_you_new_review"
  
  match "new_reviews/:id/changeShow" => 'new_reviews#changeShow'
  
  ##### REVIEWS
  
  match "/reviews/:sort_by/show_all" => "reviews#show_all"
  
  match "/reviews/show_all" => "reviews#show_all"
  
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
  
  get "/feedbacks/thank_you"
  
  match "feedbacks/:id/changeShow" => 'feedbacks#changeShow'
  
  ##### USERS
  
  devise_for :users, :controllers => {:registrations => :registrations, :sessions => :sessions}
  
  devise_scope :user do
  
    match 'sign_up' => 'devise/registrations#new'
    
    match 'unlock' => 'devise/unlocks#new'
  
    match 'sign_in' => 'devise/sessions#new'
  
    match 'signout' => 'devise/sessions#destroy'
    
    match "registrations/mustBe" => 'registrations#mustBe'
    
    match "registrations/create_org_account" => 'registrations#create_org_account'
    
    match "registrations/email_confirm" => 'registrations#email_confirm'
    
    match "registrations/are_you_sure" => 'registrations#are_you_sure'
    
    match "confirmations/new" => 'devise/confirmations#new'
    
    match "confirmations/:confirmation_token" => 'devise/confirmations#show'
    
    match "passwords/:reset_password_token" => 'devise/passwords#edit'
  
  end
  
  match 'users/profile' => "users#profile"
    
  match 'users/:id/crop' => 'users#crop'
  
  match 'users/:id/change_subscription' => 'users#change_subscription'
  
  get 'users/successful_unsubscribe'
  
  match "users/check_email" => 'users#check_email'

  match "users/check_username" => 'users#check_username'
  
  match "users/:id/crop" => 'users#crop'
  
  match "users/:id/update_crop" => 'users#update_crop'
  
  match "registrations/:id/crop" => 'registrations#crop'
  
  match "registrations/crop" => 'registrations#crop'
  
  match "users/:user_id/make_admin" => "users#make_admin"

  ##### MAD MIMI
  
  match "mad_mimi_email/new" => 'mad_mimi_email#new'

  
  ##### PAGES
  
  match "users/profile/sent_deleted" => "users#profile"
  
  match "users/profile/message_deleted" => "users#profile"
  
  match "users/profile/favorite_deleted" => "users#profile"
  
  get "organization_accounts/thank_you_request"
  
  get "pages/enable_js"
  
  get "pages/test"
  
  get "pages/home" 
  
  get "pages/profile_messages"
  
  get "pages/profile_messages_sent"
  
  get "pages/profile_favorites"
  
  get "blog_posts/resources"
  
  get "pages/about_form"
  
  get "searches/show"
  
  get "searches/index"
  
  get "searches/search_machine"
  
  get "pages/get_info"
  
  get "pages/searches"
  
  get "pages/search_machine_results"
  
  get "searches/program_browse"
  
  get "pages/program_browse_results"
  
  get "pages/sorted_results"
  
  get "pages/organization_sorted"
  
  get "feedbacks/thank_you"

  
  get "pages/about"
  get "pages/contact"
  get "pages/terms"
  get "pages/privacy"
  get "pages/faq"
  get "reviews/thank_you_review"
  get "new_reviews/thank_you_new_review"
  
  match "searches/:region/program_search" => 'searches#program_search'
  
  ###### PROGRAMS
  match "/programs/search_results" => "programs#search_results"
  
  
  ###### ORGANIZATIONS
  
  match "/organizations/:sort_by/show_all" => "organizations#show_all"
  
  match "/organizations/show_all" => "organizations#show_all"
  
  match 'organizations/:id/changeShow' => 'organizations#changeShow'
  
  match 'organizations/:id/crop' => 'organizations#crop'
  
  match "organizations/:id/edit" => 'organizations#edit'
  
  match "organizations/pages/get_info" => 'pages#get_info'
  
  match "organizations/:id/programs" => 'organizations#programs'
  
  get "organizations/program_contents"
  
  ########## BLOG POSTS
  
  match "/blog_posts/resources" => "blog_posts#resources"
  
  match "blog_posts/:id/destroy/:location" => 'blog_posts#destroy'
  
  match "pages/blog_posts" => 'blog_posts#index'
  
  match "blog_posts/resources_search" => 'blog_posts#resources_search'
  
  match "blog_posts/:id/crop" => 'blog_posts#crop'
  
  match "blog_posts/:id/square" => 'blog_posts#square'
  
  devise_for :organization_accounts, :controllers => {:invitations => :invitations, :sessions => :sessions}
  devise_scope :organization_account do
    match "/organization_accounts/sign_out" => "devise/sessions#destroy"
    match "/organization_accounts/profile" => "organization_accounts#profile"
    match "/organization_accounts/:user_id/resend_invitation" => "organization_accounts#resend_invitation" 
    match "/organization_accounts/passwords/:reset_password_token" => 'devise/passwords#edit'
  end
  
  resources :organization_accounts do
    collection do
      get :send_new_invitation, :as => :send_new_invitation
    end
  end
  
  resources :users do 
    post :send_message, :on => :collection
    collection do
      get 'checkname'
    end
  end
  
  resources :programs do
  	resources :reviews
  	post :create_review, :on => :collection
  end
 
  resources :searches
 
  resources :messages

  resources :mad_mimi_emails

  resources :contacts

  resources :flags

  resources :new_reviews

  resources :feedbacks

  resources :favorites
  
  resources :ratings
  
  
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

  resources :reviews
  
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
  
  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
  
end