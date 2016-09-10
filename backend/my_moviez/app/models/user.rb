class User < ApplicationRecord
  has_secure_password

  has_many :ratings
  belongs_to :city

  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  
end
