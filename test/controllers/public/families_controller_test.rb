require "test_helper"

class Public::FamiliesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_families_new_url
    assert_response :success
  end

  test "should get index" do
    get public_families_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_families_edit_url
    assert_response :success
  end
end
