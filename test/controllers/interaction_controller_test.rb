require 'test_helper'

class InteractionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get interaction_new_url
    assert_response :success
  end

  test "should get create" do
    get interaction_create_url
    assert_response :success
  end

  test "should get show" do
    get interaction_show_url
    assert_response :success
  end

end
