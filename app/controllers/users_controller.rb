class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation))
    if @user.save
      flash[:success] = "Your account has been created."
    else
      flash[:error] = "Please try again."
    end
    redirect_to users_path
  end

end