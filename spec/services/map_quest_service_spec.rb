require 'rails_helper'

RSpec.describe 'MapQuest Service' do
    describe 'instance methods' do
        it 'returns geolocated coordinates from a city, state', :vcr do
            service = MapQuestService.new

            location = service.get_geolocation("new orleans","la")

            expect(location).to have_key(:lat)
            expect(location).to have_key(:lng)
        end
    end
end