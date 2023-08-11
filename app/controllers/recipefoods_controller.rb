class RecipefoodsController < ApplicationController
  before_action :authenticate_user!

  def index; end
<<<<<<< HEAD

  def new
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:recipe_id])
    redirect_to recipes_path unless @recipe
    @recipefood = Recipefood.new
  end

  def create
    data = food_params
    @food = Food.create(name: data[:name], measurement_unit: data[:measurement_unit], price: data[:price],
                        quantity: data[:quantity], user: current_user)
    @food.save
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:recipe_id])
    redirect_to recipes_path unless @recipe
    @foodrecipe = Recipefood.create(quantity: data[:quantity], food: @food, recipe: @recipe)
    @foodrecipe.save
    redirect_to "/recipes/#{@recipe.id}/recipefoods/new", alert: 'Failed to add.' unless @food && @foodrecipe
    p @food, @recipe
    redirect_to "/recipes/#{@recipe.id}/recipefoods/new", notice: 'Successfully added.'
  end

  def destroy
    @foodrecipe = Recipefood.includes(:food, :recipe).where(recipe_id: params[:recipe_id], food_id: params[:id]).first
    @recipe = @foodrecipe.recipe
    redirect_to recipes_path unless @foodrecipe
    @foodrecipe.destroy
    redirect_to recipe_path(@recipe)
  end

  private

  def food_params
    params.require(:recipefood).permit(:name, :measurement_unit, :price, :quantity)
  end
=======
>>>>>>> 0c91ab647d434201bd81d5d639966a97f102ac8f
end
