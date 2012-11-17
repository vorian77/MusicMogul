Mvp2::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/account' => 'users#edit', :as => :account
  put '/account' => 'users#update'
  post '/reset_password' => 'users#reset_password', :as => :reset_password

  resources :contacts, :only => :create
  resources :follows, only: [:index]

  resources :entries, only: [:show, :create, :update] do
    resources :judgings, only: [:create]
    resource :follows, only: [:create, :destroy]
  end

  match "leaderboard" => "entries#leaderboard", as: :leaderboard

	root :to => 'home#index'

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
