class SessionsController < ApplicationController
  layout 'sessions'
  
  def new
    redirect_to admin_dashboard_path if logged_in?
  end

  def create
    user = AdminUser.find_by(email: params[:email].to_s.downcase)
    if user&.authenticate(params[:password])
      session[:admin_user_id] = user.id
      redirect_to admin_dashboard_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:admin_user_id] = nil
    redirect_to login_path, notice: "Logged out."
  end
end