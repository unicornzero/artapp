class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You are logged in.'
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid login information'
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You are logged out.'
    redirect_to root_url
  end

end