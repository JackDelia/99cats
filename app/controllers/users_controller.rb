class UsersController < ApplicationController
before_action :require_not_login, only: [:new, :create]
  def create
    @user = User.new(user_params)
    login_user!
  end

  def new
    @user = User.new
    render :new
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def require_not_login
    redirect_to cats_url unless current_user.nil?
  end
end
