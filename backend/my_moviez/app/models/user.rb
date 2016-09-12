class User < ApplicationRecord
  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :rated_movies, through: :ratings, class_name: 'Movie', source: :movie
  belongs_to :city, optional: true

  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true

  def score_for(movie)
    ratings.where(movie: movie).first.try(:score)
  end

  def has_rated?(movie)
    Rating.exists?(movie: movie, user: self)
  end
end
