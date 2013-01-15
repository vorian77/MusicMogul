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
  match "about_us" => "home#about_us"
  match "contact_us" => "home#contact_us"
  match "contest_rules" => "home#contest_rules"
  match "terms" => "home#terms"
  match "privacy" => "home#privacy"
  match "learn_more" => "home#learn_more"

  root :to => 'home#index'
  match "*a", :to => "application#routing_error"
end
