VideoPortal::Application.routes.draw do
  root 'courses#index'

  resources :courses, only: [:index, :show]
  resources :tutorials, only: [:show]

  namespace :admin do
    resources :tags
    resources :users

    resources :courses do
      resources :tutorials
    end

    resources :tutorials do
      resources :videos
    end
  end

  get "signin" => "sessions#new"
  post "sessions/create"
  get "signout" => "sessions#destroy", :as => "signout"
end
