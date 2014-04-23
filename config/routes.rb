VideoPortal::Application.routes.draw do
  root 'home#list_courses'

  scope '/admin' do
    resources :tags
    resources :users

    resources :courses do
      resources :tutorials
    end

    resources :tutorials do
      resources :videos
    end
  end

  get 'courses/:id' => 'home#course', as: :home_course
  get 'tutorial/:id' => 'home#tutorial', as: :home_tutorial

  get "signin" => "sessions#new"
  post "sessions/create"
  get "signout" => "sessions#destroy", :as => "signout"
end
