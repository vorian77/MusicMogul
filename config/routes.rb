Mvp2::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {confirmations: "confirmations",
                                   passwords: "passwords",
                                   registrations: "registrations",
                                   sessions: "sessions"}
  devise_scope :user do
    match "/users/passwords/reset" => "passwords#reset", as: :password_reset
  end
  match "/users/verify_email" => "users#verify_email", as: :verify_email
  match "/users/finish" => "entries#finish", as: :finish_entry

  resources :clicks, only: [:create]
  resources :users, only: [:new, :edit, :update] do
    member do
      get :scorecard
    end
  end
  resources :friends, only: [:index]

  resources :entries, only: [:show] do
    resources :evaluations, only: [:create, :update]
    resource :contracts, only: [:create]
    resource :follows, only: [:create, :destroy]
  end

  resources :evaluations, only: [:index]
  resources :contacts, only: [:create]

  match "leaderboard" => "users#leaderboard", as: :leaderboard
  match "my_data" => "users#my_data"
  match "contact_us" => "home#contact_us"
  match "contest_rules" => "home#contest_rules"
  match "terms" => "home#terms"
  match "privacy" => "home#privacy"

  root :to => 'home#index'
  match "*a", :to => "application#routing_error"
end
