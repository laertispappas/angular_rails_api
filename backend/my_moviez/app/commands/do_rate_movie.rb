class DoRateMovie
  prepend BaseCommand
  attr_reader :rating

  def initialize(movie, user)
    @movie = movie
    @user = user
  end

  def call
    if @user.has_rated?(@movie)

    else
      rating = @user.ratings.build(movie: @movie)
      rating.valid? ? @rating : errors.from_hash(rating.errors.messages)
    end
  end
end
