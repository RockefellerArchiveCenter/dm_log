class AddVirusCheckToDmItems < ActiveRecord::Migration[5.0]
  def change
    add_column :dm_items, :virus_check, :string
  end
end
