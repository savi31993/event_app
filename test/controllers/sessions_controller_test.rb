require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should end session" do
    delete logout_url
    assert_redirected_to events_url
  end
end
