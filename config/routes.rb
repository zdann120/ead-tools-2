Rails.application.routes.draw do
  resources :appointments, except: [:destroy, :edit, :update] do
    patch 'cancel', on: :member
  end
  namespace :express do
    resources :appointments, only: [:new, :create]
  end
  devise_for :users
  mount Sidekiq::Web => "/sidekiq" # monitoring console

  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
