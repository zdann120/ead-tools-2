Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :appointments, except: [:destroy, :edit, :update] do
    patch 'cancel', on: :member
  end
  namespace :express do
    resources :appointments, only: [:new, :create]
    post 'authenticate', to: 'appointments#authenticate'
    get 'restart', to: 'appointments#clear_session_email'
  end
  devise_for :users
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => "/sidekiq" # monitoring console

  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount_griddler
end
