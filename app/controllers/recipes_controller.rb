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
    redirect_to "/public/recipes/#{@recipe.id}"
  end

  def destroy
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:id])
    redirect_to recipes_path, alert: 'Failed to delete.' unless @recipe
    @recipe.destroy
    redirect_to recipes_path, notice: 'Item was successfully deleted.'
  end

  def new
    @recipe = Recipe.new(name: '', cooking_time: '', preparation_time: '', description: '', public: '')
  end

  def generate
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:id])
    @recipefoods = Food.includes(:user, :recipefoods).where(recipefoods: { recipe_id: params[:id] },
                                                            user: current_user).pluck(:id)
    @foods = Food.includes(:user, :recipefoods).where.not(id: @recipefoods)
    p @recipefoods
    return if @recipe

    redirect_to recipes_path
  end

  def add
    foods = params.require(:foods)
    items = Food.where(id: foods)
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:id])
    items.each do |item|
      @recipefood = Recipefood.create(quantity: item.quantity, food: item, recipe: @recipe)
      @recipefood.save
    end
  end

  def show
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:id])
    @foods = Food.includes(:user, :recipefoods).where(recipefoods: { recipe_id: params[:id] }, user: current_user)
  end
end
