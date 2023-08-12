class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.where(user_id: current_user.id)
  end

  def new
    @food = Food.new(name: '', measurement_unit: '', price: '', quantity: 1)
  end

  def create
    @food = Food.create(food_params)
    if @food.save
      redirect_to foods_path, notice: 'Item was successfully created.'
    else
      redirect_to foods_path, alert: 'Failed to create.'
    end
  end

  def shop
    @foods = Food.includes(:recipefoods).where(user: current_user)
    @food_amount = @foods.count.zero? ? 0 : @foods.count
    @total_value = @foods.sum(:price).zero? ? 0 : @foods.sum(:price)
  end

  def destroy
    @food = Food.includes(:user, :recipefoods).find_by(id: params[:id])
    redirect_to foods_path, alert: 'Failed to delete.' if @food.nil?

    @food.destroy
    redirect_to foods_path, notice: 'Item was successfully deleted.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity).merge(user_id: current_user.id)
  end
end
