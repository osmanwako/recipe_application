Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_for :users, path_names: { sign_in: "login", sign_out: "logout", password: "password", confirmation: "verification", registration: "register" }
  root "foods#index"
  resources :foods, only: [:index] do
    resources :recipefoods, only: [:index]
  end
  resources :recipes, only: [:index, :new, :show, :destroy, :update] do
    resources :recipefoods, only: [:index, :new, :create, :destroy]
  end
  resources :recipefoods, only: [:index]
  get "public/recipes", to: "recipes#public"
  get "generate/recipe/:id", to: "recipes#generate"
  post "generate/recipe/:id/add", to: "recipes#add"
  patch "public/recipes/:id", to: "recipes#update"
  get "general_shopping_list", to: "shopping_lists#index"
  resources :shopping_lists
end
