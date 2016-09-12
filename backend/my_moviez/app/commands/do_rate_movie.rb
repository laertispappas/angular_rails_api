class DoRateMovie
  prepend BaseCommand
  attr_reader :rating

  def initialize(movie, user, context_conditions = {})
    @movie = movie
    @user = user
    @context_conditions = context_conditions
  end

  def call
    rating.save ? rating : errors = rating.errors
  end


  private
  def rating
    @rating ||= begin
                  r = Rating.find_or_initialize_by(user: @user, movie: @movie)
                  r.rating_conditions.build
                  r
                end
  end
end
