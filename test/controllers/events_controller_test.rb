require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_redirected_to events_path
  end

  test "should create event" do
    assert_difference('Event.count', 0) do
      post events_url, params: { event: {  } }
    end

    assert_redirected_to events_path
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_redirected_to events_path
  end

  test "should update event" do
    patch event_url(@event), params: { event: {  } }
    assert_redirected_to events_path
  end

  test "should destroy event" do
    assert_difference('Event.count', 0) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
