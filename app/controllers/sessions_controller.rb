class SessionsController < ApplicationController
  skip_before_filter :login_required, :verify_is_admin, :load_courses

  def new
    redirect_to root_url if current_user
  end

  def create
    user = User.authenticate(params[:user])

    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now[:alert] = "Invalid Username or Password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path
  end
end
