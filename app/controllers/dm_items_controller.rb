class DmItemsController < ApplicationController
  def index
    @dm_items = DmItem.sorted
  end

  def show
    @dm_item = DmItem.find(params[:id])
  end

  def new
    @dm_item = DmItem.new({:auto_id => "default"})
  end
  
  def findByID
    refID = "ref123"
    baseURL = 'http://192.168.50.7:8089'
    token = 'a468e7a9eddcb0b3f418ae1f3863a2bf40a533e3b9e7cbd171afceddb1a694f3'    
    findByIdURL = baseURL + '/repositories/2/find_by_id/archival_objects?ref_id[]=' + refID
    findByIdJSON = open(findByIdURL, 'X-ArchivesSpace-Session' => token).read
    parsed = JSON.parse(findByIdJSON)
    archivalObjectURL = baseURL + parsed["archival_objects"].first["ref"]
    archivalObjectJSON = open(archivalObjectURL, 'X-ArchivesSpace-Session' => token).read
    parsed = JSON.parse(archivalObjectJSON)
    display_title = parsed["display_string"]
    resourceURL = baseURL + parsed["resource"]["ref"]
    resourceJSON = open(resourceURL, 'X-ArchivesSpace-Session' => token).read
    parsed = JSON.parse(resourceJSON)
    resource = parsed["title"]
  end
  
=begin
  :auto_id
  :format
  :status
  :method
  :transfer_date
  :disposition
  :notes
  :refid
  :display_title
  :resource
=end
  
  def create
    # Instantiate a new object using form parameters
    @dm_item = DmItem.new(dm_items_params)
    # Save the object
    if @dm_item.save
    # If save succees, redirect to the index action
    flash[:notice] = "Item added successfully."
    redirect_to(:action => "index")
  else
    # If save fails, redisplay the form so user can fix problems
    render("new")
  end
  end
  

  def edit
    @dm_item = DmItem.find(params[:id])
  end
  
  def update
    # Find an existing object using form parameters
    @dm_item = DmItem.find(params[:id])
    # Update the object
    if @dm_item.update_attributes(dm_items_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "DmItem updated successfully."
      redirect_to(:action => 'edit', :id => @dm_item.id)
    else
      # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

#  def delete
#    @dm_item = DmItem.find(params[:id])
#  end
  
  private 
  
  def dm_items_params
    params.require(:dm_item).permit(:auto_id, :format, :status, :method, :transfer_date, :disposition, :notes, :refid, :display_title, :resource)
end

end
