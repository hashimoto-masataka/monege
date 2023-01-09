require "test_helper"

class Public::IncomesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_incomes_new_url
    assert_response :success
  end

  test "should get index" do
    get public_incomes_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_incomes_edit_url
    assert_response :success
  end
end
