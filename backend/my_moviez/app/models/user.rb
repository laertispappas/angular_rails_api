class User < ApplicationRecord
  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :rated_movies, through: :ratings, class_name: 'Movie', source: :movie
  belongs_to :city

  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true
end
