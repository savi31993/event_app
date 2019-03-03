require 'test_helper'

class EventsSessionTest < ActionDispatch::IntegrationTest
  setup do
    login_as_jane
  end

  teardown do
    logout
  end

  test "should create event after login" do
    get new_event_url
    assert_response :success

    assert_difference('Event.count') do
      post events_url, params: { event: { name: "foo",
                                          description: "bar",
                                          image: fixture_file_upload(
                                                  '/files/image1.jpg', 'image/jpg'),
                                          category_id: categories(:food).id,
                                          date: Time.now,
                                          address: "330 Innovation Blvd, 16803"   } }
    end
  end

  test "should not create events without all params" do
    assert_difference('Event.count', 0) do
      post events_url, params: { event: { name: "foo",
                                          description: "bar",
                                          image: fixture_file_upload(
                                                  '/files/image1.jpg', 'image/jpg'),
                                          category_id: categories(:food).id,
                                          date: Time.now  } }
    end
  end

  test "should edit own event" do
    get edit_event_url(events(:one).id)
    assert_response :success
  end

  test "should not edit other's events" do
    get edit_event_url(events(:two).id)
    assert_redirected_to events_url
  end

  test "should destroy own event" do
    assert_difference('Event.count', -1) do
      delete event_url(events(:one).id)
    end

    assert_redirected_to events_url
  end

  test "shold not destroy other's events" do
    assert_difference('Event.count', 0) do
      delete event_url(events(:two).id)
    end

    assert_redirected_to events_url
  end

  test "should rsvp to event" do
    event = events(:one)

    assert_equal 0, event.rsvps.length

    post change_status_url, params: { event_id: event.id, new_status: true }

    assert_equal 1, event.reload.rsvps.length

    assert_equal true, event.rsvps[0].status
  end
end
