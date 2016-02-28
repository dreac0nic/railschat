class User < ActiveRecord::Base
  attr_accessor :password

  validates :handle, :presence => true, :uniqueness => true, :length => { :in => 4..24 }
  validates :email, :presence => true, :uniqueness => true, :format => { with: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}/i }
  validates :password, :confirmation => true
  validates :password, :length => { minimum: 6 }, :on => :create
end
