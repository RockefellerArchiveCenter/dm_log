class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params) 
    if @user.save 
      session[:user_id] = @user.id 
      redirect_to '/' 
    else 
      render("new")
    end 
  end

  def edit
  end

  def delete
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
  
end
