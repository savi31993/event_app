require 'test_helper'

class CategoriesEventsTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:food)
    login_as_jane
  end

  teardown do
    logout
  end

  test "category should have only one event" do
    assert_equal 1, @category.events.length
  end

  test "adding events should increase event count in category" do
    assert_difference('@category.events.count') do
      post events_url, params: { event: { name: "foo",
                                          description: "bar",
                                          image: fixture_file_upload(
                                                  '/files/image1.jpg', 'image/jpg'),
                                          category_id: @category.id,
                                          date: Time.now,
                                          address: "330 Innovation Blvd, 16803"   } }
    end
  end
end
