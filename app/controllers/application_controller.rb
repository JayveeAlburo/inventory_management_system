class ApplicationController < ActionController::Base
  include Pagy::Backend

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= AdminUser.find_by(id: session[:admin_user_id])
  end

  def logged_in?
    current_user.present?
  end
end