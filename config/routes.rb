Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "foods#index"
  devise_for :users

  resources :foods, only: [:index] do
    resources :recipes, only: [:index]
  end
  resources :recipes, only: [:index] do
    resources :foods, only: [:index]
  end
end
