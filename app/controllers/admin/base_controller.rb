class Admin::BaseController < ApplicationController
  before_action :require_login

  private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in to access the admin area."
    end
  end
end