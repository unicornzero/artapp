class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    user.send_password_reset if user
    redirect_to root_url, notice: 'Password reset email sent '
  end

  def edit
    @user = User.find_by!(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by!(password_reset_token: params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: 'Password reset has expired.'
    else
      @user.update_attributes(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      if @user.save
        hashy = params
        redirect_to root_url, notice: "Password has been reset! #{hashy}"
      else
        render :edit, notice: 'Please try again.'
      end
    end
    #@user.password = params[:user][:password]
    #@user.password_confirmation = params[:user][:password_confirmation]
    #@user.assign_attributes(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
  end
end