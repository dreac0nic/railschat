class AddPasswordFieldsToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :password_hash, :string
    add_column :rooms, :password_salt, :string
  end
end
