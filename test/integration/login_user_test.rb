require 'test_helper'

class UsersSessionTest < ActionDispatch::IntegrationTest
  setup do
    login_as_jane
  end

  teardown do
    logout
  end

  test "should edit self" do
    get edit_user_url(users(:jane).id)

    assert_response :success
  end

  test "should update self" do
    patch user_url(users(:jane).id), params: { user: { name: "Sally" } }

    assert_equal "Sally", users(:jane).reload.name

    assert_redirected_to user_url(users(:jane).id)
  end

  test "should not edit others" do
    get edit_user_url(users(:john).id)

    assert_redirected_to events_url
  end

  test "should not destroy others" do
    assert_difference('User.count', 0) do
      delete user_url(users(:john).id)
    end

    assert_redirected_to events_url
  end
end
