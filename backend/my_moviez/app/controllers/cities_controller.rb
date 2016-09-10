class CitiesController < ApplicationController
  # GET    /api/countries/:country_code/states/:state_code/cities
  def index
    country = Country.find_by!(code: params[:country_code])
    state = country.states.find_by!(code: params[:state_code])
    cities = state.cities

    render json: cities
  end
end
