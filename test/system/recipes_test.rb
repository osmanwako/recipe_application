require 'application_system_test_case'

class RecipesTest < ApplicationSystemTestCase
  setup do
    @current_user = users(:user_one)
    @user = users(:user_two)
    @recipeone = recipes(:recipe_one)
    @recipetwo = recipes(:recipe_two)
    sign_in(@current_user)
    visit recipes_path
  end

  test 'Testing Recipes List for signed in User' do
    assert_selector 'a', text: @recipeone.name
    assert_selector 'div', text: @recipeone.description
  end

  test 'Testing Recipes List for not signed in user' do
    assert_no_selector 'a', text: @recipetwo.name
    assert_no_selector 'div', text: @recipetwo.description
  end

  test 'Testing Recipe List link add Recipe' do
    click_link 'Add Recipe'
    assert_selector 'h3', text: 'Add New Recipe'
  end

  test 'Testing Recipe Form' do
    click_link 'Add Recipe'
    fill_in 'Name', with: 'Recipe four(4)'
    fill_in 'Preparation time', with: '12hr'
    fill_in 'Cooking time', with: '0.45hr'
    fill_in 'Description', with: 'Recipe four(4) description'
    click_on 'Add'
    assert_text 'Item was successfully created.'
  end
end
