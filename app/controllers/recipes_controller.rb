class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.includes(:user, :recipefoods).all
  end

  def public
    @recipes = Recipe.includes(:user, :recipefoods).where(public: true)
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe.nil?
      redirect_to recipes_path
    end
    @recipe.update(public: !@recipe.public)
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
    return unless @recipe

    food_id = @recipe.recipefoods.pluck(:food_id)
    return unless food_id.length > 0

    @foods = Food.where(id: food_id)
  end
end
