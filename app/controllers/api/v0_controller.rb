
class Api::V0Controller < ApplicationController
  
  # skip_before_action :authenticate_user!
  
  skip_before_action :verify_authenticity_token
  
  
  def show
    render :json => DmItem.find(params["id"])
  end
  
  def index
    render :json => DmItem.all
  end
  
  def update
    # Find an existing object using form parameters
    @dm_item = DmItem.find(params[:id])
    # Update the object
    if @dm_item.update_attributes(dm_items_params)
      render :json => @dm_item
    end
  end
  
  private
#shows required parameters
  def dm_items_params
    params.permit(:dm_item, :auto_id, :format, :status, :method, :transfer_date, :disposition, :notes, :refid, :display_title, :resource, :search, :modified_by)
end

end