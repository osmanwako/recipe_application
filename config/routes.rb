Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_for :users, path_names: { sign_in: "login", sign_out: "logout", password: "password", confirmation: "verification", registration: "register" }
  root "foods#index"
  resources :foods, only: [:index] do
    resources :recipefoods, only: [:index]
  end
  resources :recipes, only: [:index, :show, :destroy, :update] do
    resources :recipefoods, only: [:index]
  end
  resources :recipefoods, only: [:index]
  get "public/recipes", to: "recipes#public"
  patch "public/recipes/:id", to: "recipes#update"
end
