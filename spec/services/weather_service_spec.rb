require 'rails_helper'

RSpec.describe 'Weather Service' do
    describe 'instance methods' do
        it 'returns 5 day forecast for a given lat and lon.', :vcr do
            service = WeatherService.new

            forecast = service.get_forecast
            expect(forecast).to have_key(:current)
            # expect(forecast).to have_key(:lng)
        end
    end
end