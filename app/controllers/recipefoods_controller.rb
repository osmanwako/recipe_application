class RecipefoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:recipe_id])
    redirect_to recipes_path if @recipe.nil?
    @recipefoods = Food.includes(:user, :recipefoods).where(recipefoods: { recipe_id: params[:recipe_id] },
                                                            user: current_user).pluck(:id)
    @foods = Food.includes(:user, :recipefoods).where.not(id: @recipefoods)
  end

  def generate
    foods = params.require(:foods)
    items = Food.where(id: foods)
    @recipe = Recipe.find_by(id: params[:id])
    items.each do |item|
      @recipefood = Recipefood.create(quantity: item.quantity, food: item, recipe: @recipe)
      @recipefood.save
    end
    redirect_to recipe_path(id: params[:id])
  end

  def new
    @recipe = Recipe.find_by(id: params[:recipe_id])
    redirect_to recipes_path if @recipe.nil?
    @recipefood = Recipefood.new
  end

  def create
    @recipe = Recipe.find_by(id: params[:recipe_id])
    redirect_to recipes_path if @recipe.nil?
    data = food_params
    @food = Food.create(data)
    @food.save
    @foodrecipe = Recipefood.create(quantity: data[:quantity], food_id: @food.id, recipe_id: params[:recipe_id])
    @foodrecipe.save
    if @foodrecipe.id == nil?
      redirect_to "/recipes/#{params[:recipe_id]}/recipefoods/new", alert: 'Failed to add.'
    else
      redirect_to "/recipes/#{params[:recipe_id]}/recipefoods/new", notice: 'Successfully added.'
    end
  end

  def destroy
    @recipefoods = Recipefood.where(recipe_id: params[:recipe_id], food_id: params[:id])
    if @recipefoods.nil?
      redirect_to recipes_path
    else
      @recipefoods.destroy_all
      redirect_to recipe_path(id: params[:recipe_id])
    end
  end

  private

  def food_params
    params.require(:recipefood).permit(:name, :measurement_unit, :price, :quantity).merge(user_id: current_user.id)
  end
end
