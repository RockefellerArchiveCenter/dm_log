class ApplicationController < ActionController::Base
  
  acts_as_token_authentication_handler_for User
  
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  
#  helper_method :current_user 

#  def current_user 
#    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
#  end
#  
#  def require_user 
#    redirect_to '/login' unless current_user 
#  end
  
end
