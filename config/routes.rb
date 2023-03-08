Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/dashboard", to: "pages#dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :answers, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :career_options, only: [:new, :create]
  resources :priorities, only: [:new, :create]
end
