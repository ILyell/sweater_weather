require 'rails_helper'

RSpec.describe 'Weather Service' do
    describe 'instance methods' do
        it 'returns 5 day forecast for a given lat and lon.', :vcr do
            service = WeatherService.new
            forecast = service.get_forecast("new orleans","la")
            expect(forecast).to have_key(:location)
            expect(forecast[:location]).to have_key(:lat)
            expect(forecast[:location]).to have_key(:lon)
        end
    end
end