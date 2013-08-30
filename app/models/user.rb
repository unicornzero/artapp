class User < ActiveRecord::Base

  has_secure_password

  validates :password, length: { minimum: 6, maximum: 16 }


end