class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    return @current_user
  end
  helper_method :current_user

  def login(user_id)
    session[:user_id] = user_id
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    redirect_to events_path
  end

  def get_rsvp_info(event_id)
    @has_rsvp_ed = false
    @rsvp_id = 0
    @status = false

    event = Event.find(event_id)

    event.rsvps.each do |rsvp|
      if rsvp.user == current_user
        @has_rsvp_ed = true
        @rsvp_id = rsvp.id
        @status = rsvp.status
        break
      end
    end
  end
  helper_method :get_rsvp_info
end
