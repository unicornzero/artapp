class UsersController < ApplicationController

  before_action :authorize, only: :admin_page

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation))
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Your account has been created."
      redirect_to users_path
    else
      flash[:error] = "Please try again."
      render :new
    end
  end

  def admin_page
  end
end