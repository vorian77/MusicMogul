Mvp2::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/account' => 'users#edit', :as => :account
  put '/account' => 'users#update'
  post '/account/profile_photo' => 'users#create_profile_photo', :as => :account_profile_photo
  delete '/account/profile_photo' => 'users#remove_profile_photo'
  post '/account/profile_video' => 'users#create_profile_video', :as => :account_profile_video
  delete '/account/profile_video' => 'users#remove_profile_video', :as => :remove_profile_video
  post '/account/entry/performance_video' => 'users#create_entry_performance_video', :as => :account_entry_performance_video
  delete '/account/entry/performance_video' => 'users#remove_entry_performance_video', :as => :remove_entry_performance_video
  get '/account/thumbnail' => 'users#edit_thumbnail', :as => :edit_thumbnail
  put '/account/thumbnail' => 'users#update_thumbnail', :as => :update_thumbnail
  post '/reset_password' => 'users#reset_password', :as => :reset_password

  resources :contacts, :only => :create
  resources :previews, :only => [:index, :show]

  resources :entries, only: [:show] do
    resources :judgings, only: [:create]
  end

  match 'video' => 'home#video', :as => :home_video
 
  get '/upload' => 'users#upload', :as => :upload
  get '/s3_callback' => 'users#s3_callback', :as => :s3_callback

	root :to => 'home#index'
	
  # get '/Fans' => 'home#fans', :as => :home_fans
	
	get '/page/:name' => 'pages#show', :as => :page
  post '/page/notices' => 'contacts#create', :as => :contacts
	
	get '/channel.html' => proc {
    [
      200,
      {
        'Pragma'        => 'public',
        'Cache-Control' => "max-age=#{1.year.to_i}",
        'Expires'       => 1.year.from_now.to_s(:rfc822),
        'Content-Type'  => 'text/html'
      },
      ['<script type="text/javascript" src="//connect.facebook.net/en_US/all.js"></script>']
    ]
  }

end
