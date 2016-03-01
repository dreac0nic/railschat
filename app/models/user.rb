class User < ActiveRecord::Base
  USER_EMAIL_REGEXP = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}/i

  has_many :rooms
  has_many :messages
  
  attr_accessor :password

  before_save :encrypt_password
  after_save :clear_password

  validates :handle, :presence => true, :uniqueness => true, :length => { :in => 4..24 }
  validates :email, :presence => true, :uniqueness => true, :format => { with: USER_EMAIL_REGEXP }
  validates :password, :confirmation => true
  validates :password, :length => { minimum: 6 }, :on => :create

  def avatar_url
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase.strip)}"
  end

  def self.authenticate(login_name = "", login_password = "")
    if USER_EMAIL_REGEXP.match(login_name)
      user = User.find_by_email login_name
    else
      user = User.find_by_handle login_name
    end

    if user && user.has_matching_password?(login_password)
      return user
    end

    return false
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

  def has_matching_password?(password_query = "")
    self.password_hash == BCrypt::Engine.hash_secret(password_query, self.password_salt)
  end
end
