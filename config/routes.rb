Mvp2::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users

  get '/account' => 'users#edit', :as => :account
  put '/account' => 'users#update'
  post '/reset_password' => 'users#reset_password', :as => :reset_password

  resources :follows, only: [:index]

  resources :entries, only: [:new, :edit, :show, :create, :update] do
    resources :evaluations, only: [:create]
    resource :follows, only: [:create, :destroy]
  end

  resources :evaluations, only: [:index]

  match "leaderboard" => "entries#leaderboard", as: :leaderboard
  match "notices" => "home#notices"

  root :to => 'home#index'
end
