class UsersController < ApplicationController

  before_action :authorize, only: [:admin_page, :show]

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @pages = current_user.spaces
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

private
  def current_resource
    @current_resource ||= current_user
  end
end