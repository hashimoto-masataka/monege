require "test_helper"

class Public::HouseholdAccountControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_household_account_new_url
    assert_response :success
  end

  test "should get index" do
    get public_household_account_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_household_account_edit_url
    assert_response :success
  end
end
