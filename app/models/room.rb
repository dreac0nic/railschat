class Room < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: "user_id"
  has_many :users, through: :passports
  has_many :messages
  
  attr_accessor :password

  before_save :encrypt_password
  after_save :clear_password
  
  validates :topic, :presence => true, :length => { :in => 4..120 }
  validates :user_id, :presence => true
  validates :password, :confirmation => true
  # validates :password, :format => { :with => /\A\S+\z/, :message => "cannot contain any whitespace" }

  def password_protected?
    self.password_salt != "" && self.password_hash != ""
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    else
      self.password_salt = ""
      self.password_hash = ""
    end
  end

  def clear_password
    password = nil
    password_confirmation = nil
  end
end
