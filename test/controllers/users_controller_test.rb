require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jane)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "cannot create user without name" do
    assert_difference('User.count', 0) do
      post users_url, params: { user: { email: "test@test.com" } }
    end
  end

  test "cannot create user without email" do
    assert_raise(NoMethodError) do
      post users_url, params: { user: { name: "Savithri" } }
    end
  end

  test "cannot create user without password" do
    assert_difference('User.count', 0) do
      post users_url, params: { user: { name: "Savithri",
        email: "example@example.com" } }
    end
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { name: "Savithri",
        email: "foo@bar.baz.com", password: "foo",
        password_confirmation: "foo" } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_redirected_to events_path
  end

  test "should update user" do
    patch user_url(@user), params: { user: {  } }
    assert_redirected_to events_path
  end

  test "should destroy user" do
    assert_difference('User.count', 0) do
      delete user_url(@user)
    end

    assert_redirected_to events_url
  end
end
