Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_for :users, path_names: { sign_in: "login", sign_up: "register", sign_out: "logout", password: "password", confirmation: "verification" }
  root "foods#index"

  resources :foods, only: [:index, :new, :create, :destroy] do
    resources :recipefoods, only: [:index]
  end

  resources :recipes, only: [:index, :new, :show, :destroy, :create, :update] do
    resources :recipefoods, only: [:index, :new, :create, :destroy]
  end
  resources :recipefoods, only: [:index]
  get "public/recipes", to: "recipes#public"
  patch "public/recipes/:id", to: "recipes#update"
  post "generate/recipe/:id/add", to: "recipefoods#generate"
  get "general/food/shopping", to: "foods#shop"
end
