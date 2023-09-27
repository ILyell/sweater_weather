require 'rails_helper'

RSpec.describe Api::V0::RoadTripController, type: :request do

    before(:each) do
        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
            "email": "whatever@example.com",
            "password": "password",
            "password_confirmation": "password"
        }

        body = JSON.generate(params)
    
        post '/api/v0/users', headers: headers, params: body

        
        data = JSON.parse(response.body, symbolize_names: true)

        @key = data[:data][:attributes][:api_key]

    end


    it 'sends current weather data for a city', :vcr do

        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
            "origin": "new orleans, la",
            "destination": "baton rouge, la",
            "api_key": @key
        }

        body = JSON.generate(params)

        post api_v0_road_trip_path, headers: headers, params: body

        expect(response).to be_successful

        road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(road_trip).to have_key(:data)

        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data]).to have_key(:attributes)

        expect(road_trip[:data][:attributes]).to have_key(:start_city)
        expect(road_trip[:data][:attributes][:start_city]).to eq("new orleans, la")

        expect(road_trip[:data][:attributes]).to have_key(:end_city)
        expect(road_trip[:data][:attributes][:end_city]).to eq("baton rouge, la")

        expect(road_trip[:data][:attributes]).to have_key(:travel_time)
        expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)

        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:condition)
    end

    it 'returns 401 if api_key is invalid' do

        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
            "origin": "new orleans, la",
            "destination": "baton rouge, la",
            "api_key": 'fakekeyhere'
        }

        body = JSON.generate(params)

        post api_v0_road_trip_path, headers: headers, params: body

        expect(response.status).to eq(401)
    end

    it 'says travel is impossible if travel by road not possible', :vcr do
        headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
        params = {
            "origin": "new orleans, la",
            "destination": "dublin",
            "api_key": @key
        }

        body = JSON.generate(params)

        post api_v0_road_trip_path, headers: headers, params: body

        expect(response).to be_successful

        road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(road_trip[:data][:attributes][:travel_time]).to eq("Travel is impossible!")
    end
end