class RemovePasswordFromRooms < ActiveRecord::Migration
  def change
    remove_column :rooms, :password, :string
  end
end
