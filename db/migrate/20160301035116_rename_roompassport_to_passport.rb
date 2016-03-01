class RenameRoompassportToPassport < ActiveRecord::Migration
  def change
    rename_table :room_passports, :passports
  end
end
