Mvp2::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {confirmations: "confirmations", registrations: "registrations"}
  match "/users/verify_email" => "users#verify_email", as: :verify_email

  resources :users, only: [:edit, :update]
  resources :follows, only: [:index]
  resources :friends, only: [:index]

  resources :entries, only: [:new, :edit, :show, :create, :update] do
    resources :evaluations, only: [:create]
    resource :follows, only: [:create, :destroy]
  end

  resources :evaluations, only: [:index]
  resources :contacts, only: [:create]

  match "leaderboard" => "entries#leaderboard", as: :leaderboard
  match "notices" => "home#notices"
  match "about_us" => "home#about_us"
  match "contact_us" => "home#contact_us"
  match "learn_more" => "home#learn_more"

  root :to => 'home#index'
  match "*a", :to => "application#routing_error"
end
