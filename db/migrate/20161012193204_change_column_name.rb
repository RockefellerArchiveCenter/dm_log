class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :encrypted_password, :password_digest
  end
end
