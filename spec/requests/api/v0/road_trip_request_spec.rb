require 'rails_helper'

RSpec.describe Api::V0::RoadTripsController, type: :request do
    it 'sends current weather data for a city', :vcr do

        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
            "email": "whatever@example.com",
            "password": "password",
            "password_confirmation": "password"
        }

        body = JSON.generate(params)
    
        post '/api/v0/users', headers: headers, params: body

        expect(response.status).to eq(201)
        
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:data][:attributes]).to have_key(:api_key)

        key = data[:data][:attributes][:api_key]

        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
            "origin": "new orleans, la",
            "destination": "baton rouge, la",
            "api_key": key
        }

        body = JSON.generate(params)

        post api_v0_road_trip_path, headers: headers, params: body

        expect(response).to be_successful

        weather = JSON.parse(response.body, symbolize_names: true)

        expect(weather).to have_key(:data)

        expect(weather[:data]).to have_key(:id)
        expect(weather[:data][:type]).to eq("forecast")
        expect(weather[:data]).to have_key(:attributes)

        end
end