class SessionsController < ApplicationController
  def new
  end
  
# log in user
  def create
  @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
    session[:user_id] = @user.id
    redirect_to '/'
    else
      render "new"
    end 
  end
  
# log out user
  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
