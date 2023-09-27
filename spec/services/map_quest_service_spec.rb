require 'rails_helper'

RSpec.describe 'MapQuest Service' do
    describe 'instance methods' do
        it 'returns geolocated coordinates from a city, state', :vcr do
            service = MapQuestService.new

            location = service.get_geolocation("new orleans, la")

            expect(location).to have_key(:lat)
            expect(location).to have_key(:lng)
        end

        it 'returns time to destination from 2 given locations', :vcr do
            service = MapQuestService.new

            time = service.get_route_time('new orleans, la', 'baton rouge, la')
            
            expect(time).to eq(4279)
        end
    end
end