module Api
  module V1
    class RatingsController < ApiController
      def create
        movie = Movie.find(params[:movie_id])
        command = DoRateMovie.call(movie, current_user)
        if command.success?
          render json: command.result
        else
          render json: command.errors, status: 422
        end
      end
    end
  end
end
