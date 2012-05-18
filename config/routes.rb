Mvp2::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/account' => 'users#edit', :as => :account
  put '/account' => 'users#update'
  post '/account/profile_video' => 'users#create_profile_video', :as => :account_profile_video
  post '/account/entry/performance_video' => 'users#create_entry_performance_video', :as => :account_entry_performance_video
  get '/account/thumbnail' => 'users#edit_thumbnail', :as => :edit_thumbnail
  put '/account/thumbnail' => 'users#update_thumbnail', :as => :update_thumbnail
  post '/reset_password' => 'users#reset_password', :as => :reset_password

  resources :contacts, :only => :create

  match 'video' => 'home#video', :as => :home_video
 
  get '/upload' => 'users#upload', :as => :upload
  get '/s3_callback' => 'users#s3_callback', :as => :s3_callback

	root :to => 'home#index'
	
  # get '/Fans' => 'home#fans', :as => :home_fans
	
	get '/page/:name' => 'pages#show', :as => :page

end
