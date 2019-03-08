class AddModifiedBy < ActiveRecord::Migration[5.0]
  def change
    add_column :dm_items, :modified_by, :string
  end
end
