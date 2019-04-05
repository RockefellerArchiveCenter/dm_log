
class Api::V0Controller < ApplicationController

  
  def dm_item
    render :json => DmItem.find(params["id"])
  end


end