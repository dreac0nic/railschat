class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :topic
      t.string :password
      t.boolean :unlisted
      t.boolean :chat_public
      t.integer :user_id
    end
  end
end
