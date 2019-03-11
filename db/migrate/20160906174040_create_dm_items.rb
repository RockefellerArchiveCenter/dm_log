class CreateDmItems < ActiveRecord::Migration[5.0]
  def change
    create_table :dm_items do |t|
      t.string :auto_id
      t.string :format
      t.string :status
      t.string :method
      t.string :disposition
      t.string :method
      t.date :transfer_date
      t.text :notes
      t.string :refid
      t.string :display_title
      t.string :resource
      t.string :virus_check
      t.timestamps
    end
  end
end
