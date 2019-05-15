
class Api::V0Controller < ApplicationController
  
  # skip_before_action :authenticate_user!
  
  def show
    render :json => DmItem.find(params["id"])
  end


end