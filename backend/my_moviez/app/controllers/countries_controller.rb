class CountriesController < ApplicationController
  # GET    /api/countries
  def index
    render json: Country.includes(:states).all
  end
end
