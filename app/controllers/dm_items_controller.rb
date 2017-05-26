class DmItemsController < ApplicationController
  
  
  def index
    @dm_items = DmItem.search(params[:search]).page(params[:page]).order('updated_at DESC').per_page(10)
  end

  def show
    @dm_item = DmItem.find(params[:id])
  end

  def new
    @dm_item = DmItem.new()
  end
  
  
  def create
    # Instantiate a new object using form parameters
    @dm_item = DmItem.new(dm_items_params)
    # Save the object
    if @dm_item.save
    # If save succees, redirect to the index action
    flash[:notice] = "Item added successfully."
    redirect_to(:action => 'show', :id => @dm_item.id)
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
      redirect_to(:action => 'show', :id => @dm_item.id)
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
    params.require(:dm_item).permit(:auto_id, :format, :status, :method, :transfer_date, :disposition, :notes, :refid, :display_title, :resource, :search)
end

end
