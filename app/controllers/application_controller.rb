class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= if session[:user_id]
    User.find_by_id(session[:user_id])
    end
  end
  helper_method :current_user

  def authorize_user
    unless current_user
      redirect_to root_path, alert: "You need to login to continue."
    end
  end
end
