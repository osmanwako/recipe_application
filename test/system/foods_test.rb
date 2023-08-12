require 'application_system_test_case'

class FoodsTest < ApplicationSystemTestCase
  setup do
    @current_user = users(:user_one)
    @user = users(:user_two)
    @foodone = foods(:food_one)
    @foodtwo = foods(:food_two)
    @foodthree = foods(:food_three)
    sign_in(@current_user)
    visit foods_path
  end

  test 'Testing Food List table header every User' do
    assert_selector 'th', text: 'Food'
    assert_selector 'th', text: 'Measurement Unit'
    assert_selector 'th', text: 'Quantity'
    assert_selector 'th', text: 'Unit Price'
  end

  test 'Testing Food List table data for signed user' do
    assert_selector 'td', text: @foodone.name
    assert_selector 'td', text: @foodone.quantity
    assert_selector 'td', text: @foodone.measurement_unit
    assert_selector 'td', text: @foodone.price
  end

  test 'Testing Food List table data for other user' do
    assert_no_selector 'td', text: @foodtwo.name
    assert_no_selector 'td', text: @foodtwo.quantity
    assert_no_selector 'td', text: @foodtwo.measurement_unit
    assert_no_selector 'td', text: @foodtwo.price
  end

  test 'Testing Food List link add food' do
    click_link 'Add Food'
    assert_selector 'h3', text: 'Add New Food'
  end

  test 'Testing Form add food' do
    click_link 'Add Food'
    fill_in 'Name', with: 'Food Four'
    fill_in 'Measurement unit', with: 'Litres'
    fill_in 'Price', with: 746.45
    fill_in 'Quantity', with: 45
    click_on 'Add'
    assert_text 'Food Four'
  end
end
