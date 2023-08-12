class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.includes(:user, :recipefoods).where(user: current_user)
  end

  def public
    @recipes = Recipe.includes(:user, :recipefoods).where(public: true)
  end

  def new
    @recipe = Recipe.new name: '', cooking_time: '', preparation_time: '', description: '', public: ''
  end

  def create
    @recipe = Recipe.create(recipe_params)
    @recipe.save
    if @recipe.id == nil?
      redirect_to new_recipe_path, alert: 'Failed to create.'
    else
      redirect_to new_recipe_path, notice: 'Item was successfully created.'
    end
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    redirect_to recipes_path if @recipe.nil?
    @recipe.update(public: !@recipe.public)
    redirect_to "/public/recipes/#{@recipe.id}"
  end

  def destroy
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:id])
    redirect_to recipes_path, alert: 'Failed to delete.' unless @recipe
    @recipe.destroy
    redirect_to recipes_path, notice: 'Item was successfully deleted.'
  end

  def show
    @recipe = Recipe.includes(:user, :recipefoods).find_by(id: params[:id])
    @foods = Food.includes(:user, :recipefoods).where(recipefoods: { recipe_id: params[:id] }, user: current_user)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description,
                                   :public).merge(user_id: current_user.id)
  end
end
