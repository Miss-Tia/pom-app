class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_default_format

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this section."
      redirect_to login_path
    end
  end

  private

  def set_default_format
    request.format = :html unless request.format.json? || request.format.xml?
  end
end
