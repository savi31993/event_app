require 'test_helper'

class CategoriesSessionTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:food)
    login_as_jane
  end

  teardown do
    logout
  end

  test "should edit categories after login" do
    get edit_category_url(@category.id)
    assert_response :success
  end

  test "should not destroy after login" do
    assert_difference('Category.count', 0) do
      delete category_url(@category.id)
    end
  end

  test "should create category after login" do
    get new_category_url
    assert_response :success

    assert_difference('Category.count') do
      post categories_url, params: { category: { name: "foo",
                                                 description: "bar",
                                                image: fixture_file_upload(
                                                  '/files/image1.jpg',
                                                  'image/jpg') } }
    end
  end

  test "should not create category without all params" do
    assert_difference('Category.count', 0) do
      post categories_url, params: { category: { name: "hungry" } }
    end

    assert_response :success
  end
end
