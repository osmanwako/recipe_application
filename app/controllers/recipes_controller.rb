class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.includes(:user, :recipefoods).all
  end

  def public
    @recipes = Recipe.includes(:user, :recipefoods).where(public: true)
  end

  def update
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:id])
    if (@recipe)
      @recipe.update(public: !@recipe.public)
    end
    redirect_to "/public/recipes/#{@recipe.id}"
  end

  def destroy
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:id])
    unless (@recipe)
      redirect_to recipes_path, alert: "Failed to delete."
    end
    @recipe.destroy
    redirect_to recipes_path, notice: "Item was successfully deleted."
  end

  def show
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:id])
  end
end
