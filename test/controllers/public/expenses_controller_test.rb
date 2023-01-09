require "test_helper"

class Public::ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_expenses_new_url
    assert_response :success
  end

  test "should get index" do
    get public_expenses_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_expenses_edit_url
    assert_response :success
  end
end
