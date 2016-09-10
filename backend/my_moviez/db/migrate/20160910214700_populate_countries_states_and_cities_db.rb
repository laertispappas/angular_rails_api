class PopulateCountriesStatesAndCitiesDb < ActiveRecord::Migration[5.0]
  def change
    # Uses Country State gem
    ActiveRecord::Base.transaction do
      CS.countries.each do |country_code, country_name|
        country = Country.create!(code: country_code.downcase, name: country_name)
        CS.states(country.code).each do |state_code, state_name|
          state = State.create!(code: state_code.downcase, name: state_name, country: country)
          CS.cities(state.code, country.code).each do |city_name|
            City.create!(name: city_name, state: state)
          end
        end
      end
    end
  end
end
