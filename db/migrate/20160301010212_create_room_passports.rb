class CreateRoomPassports < ActiveRecord::Migration
  def change
    create_table :room_passports do |t|
      t.integer :user_id
      t.integer :room_id

      t.timestamps null: false
    end
  end
end
