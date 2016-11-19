class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: { case_sensitive: false }
  #validates :username, uniqueness: { case_sensitive: false }
  #validates :password, length: { in: 6..10 }
  validates :password, presence: true
end
