class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :login_required, :verify_is_admin

  protected

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def verify_is_admin
    redirect_to root_url unless @current_user.is_admin
  end

  def login_required
    redirect_to signin_path, :alert => 'Please login.' unless current_user
  end
end
