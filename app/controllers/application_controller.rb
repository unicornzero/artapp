class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
  end
  helper_method :current_user

  def authorize
    if params[:id] && !current_permission.allow?(params[:controller], params[:action], params[:id])
      redirect_to root_url, alert: 'Not Authorized.'
    elsif !params[:id] && !current_permission.allow?(params[:controller], params[:action])
      redirect_to root_url, alert: 'Not Authorized.'
    end
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end
end
