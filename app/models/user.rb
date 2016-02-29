class User < ActiveRecord::Base
  attr_accessor :password

  before_save :encrypt_password
  after_save :clear_password

  validates :handle, :presence => true, :uniqueness => true, :length => { :in => 4..24 }
  validates :email, :presence => true, :uniqueness => true, :format => { with: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}/i }
  validates :password, :confirmation => true
  validates :password, :length => { minimum: 6 }, :on => :create

  def avatar_url
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase.strip)}"
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt);
    end
  end

  def clear_password
    password = nil
    password_confirmation = nil
  end
end
