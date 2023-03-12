Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/dashboard", to: "pages#dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :answers, only: [:index, :show, :edit, :update, :destroy]
  resources :career_options, only: [:new, :create] do
    resources :answers, only: [:new, :create]
  end
  resources :priorities, only: [:new, :create, :edit, :update]
end
