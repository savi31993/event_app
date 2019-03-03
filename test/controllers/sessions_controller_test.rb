require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controller = SessionsController.new
  end

  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should end session" do
    delete logout_url
    assert_redirected_to events_url
  end

  test "should not login with invalid email" do
    post login_url, params: { session: { email: "jude@foo.com",
                                         password: "foo" } }

    assert_nil @controller.current_user

    assert_response :success
  end

  test "should not login with invalid password" do
    post login_url, params: { session: { email: "jane.doe@example.com",
                                         password: "loo" } }
    assert_nil @controller.current_user

    assert_response :success
  end

  test "should login with valid email and password" do
    login_as_jane

    assert_equal @controller.current_user, users(:jane)
    assert_redirected_to events_path

    logout

    assert_nil @controller.current_user
  end
end
