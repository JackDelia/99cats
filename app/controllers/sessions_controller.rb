class SessionsController < ApplicationController
before_action :require_not_login, only: [:new, :create]
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params)
    if @user.nil?
      flash.now[:errors] = "Invalid Username/Password"
      render :new
    else
      login_user!
    end
  end

  def destroy
    c = current_user
    c.reset_session_token!
    c.save
    redirect_to cats_url
  end

  private
  def require_not_login
    redirect_to cats_url unless current_user.nil?
  end

end
