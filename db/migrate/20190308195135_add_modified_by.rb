class AddModifiedBy < ActiveRecord::Migration[5.1]
  def change
    add_column :dm_items, :modified_by, :string
  end
end
