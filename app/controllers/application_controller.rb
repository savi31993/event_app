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
end
