
class Api::V0Controller < ApplicationController
  
  skip_before_action :authenticate_user!
  
  def dm_item
    render :json => DmItem.find(params["id"])
  end


end