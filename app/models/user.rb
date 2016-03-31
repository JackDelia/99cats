require 'bcrypt'

class User < ActiveRecord::Base
  validates :user_name, :password_digest, presence: true
  validates :user_name, uniqueness: true

  def self.find_by_credentials(credentials)
    user = User.find_by(user_name: credentials[:user_name])
    return nil if user.nil?
    return user if user.is_password?(credentials[:password])
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  has_many :cats
  has_many :cat_rental_requests
end
