class RemoveUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :users
  end
end
