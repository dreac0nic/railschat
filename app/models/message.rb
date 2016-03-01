class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  validates :content, :presence => true, :length => { :in => 1..420 }
  validates :user_id, :presence => true
  validates :room_id, :presence => true
end
