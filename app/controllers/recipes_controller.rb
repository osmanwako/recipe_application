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
    @recipe.update(public: !@recipe.public) if @recipe
    @recipe.update(public: !@recipe.public) if @recipe
    redirect_to "/public/recipes/#{@recipe.id}"
  end

  def destroy
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:id])
    redirect_to recipes_path, alert: "Failed to delete." unless @recipe
    @recipe.destroy
    redirect_to recipes_path, notice: "Item was successfully deleted."
  end

  def show
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:id])
    @foods = []
    if (@recipe)
      food_id = @recipe.recipefoods.pluck(:food_id)
      if (food_id.length > 0)
        @foods = Food.where(id: food_id)
      end
    end
  end
end
