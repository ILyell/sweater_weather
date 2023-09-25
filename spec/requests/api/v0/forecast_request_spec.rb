require 'rails_helper'

RSpec.describe Api::V0::ForecastsController, type: :request do
    it 'sends current weather data for a city', :vcr do

        get api_v0_forecast_path, params: { city: 'new orleans', state: 'LA' }

        expect(response).to be_successful

        weather = JSON.parse(response.body, symbolize_names: true)

        expect(weather).to have_key(:data)

        expect(weather[:data]).to have_key(:id)
        expect(weather[:data][:type]).to eq("forecast")
        expect(weather[:data]).to have_key(:attributes)

        expect(weather[:data][:attributes]).to have_key(:current_weather)
        expect(weather[:data][:attributes]).to have_key(:daily_weather)
        expect(weather[:data][:attributes]).to have_key(:hourly_weather)
        
        expect(weather[:data][:attributes][:current_weather]).to have_key(:last_updated)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:temperature)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:feels_like)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:humidity)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:uvi)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:visibility)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:condition)
        expect(weather[:data][:attributes][:current_weather]).to have_key(:icon)

        expect(weather[:data][:attributes][:daily_weather]).to be_a(Array)
        expect(weather[:data][:attributes][:daily_weather].count).to eq(5)

        expect(weather[:data][:attributes][:daily_weather][0]).to have_key(:date)
        expect(weather[:data][:attributes][:daily_weather][0]).to have_key(:sunrise)
        expect(weather[:data][:attributes][:daily_weather][0]).to have_key(:sunset)
        expect(weather[:data][:attributes][:daily_weather][0]).to have_key(:max_temp)
        expect(weather[:data][:attributes][:daily_weather][0]).to have_key(:min_temp)
        expect(weather[:data][:attributes][:daily_weather][0]).to have_key(:condition)
        expect(weather[:data][:attributes][:daily_weather][0]).to have_key(:icon)

        expect(weather[:data][:attributes][:hourly_weather]).to be_a(Array)
        expect(weather[:data][:attributes][:hourly_weather].count).to eq(24)

        expect(weather[:data][:attributes][:hourly_weather][0]).to have_key(:time)
        expect(weather[:data][:attributes][:hourly_weather][0]).to have_key(:temperature)
        expect(weather[:data][:attributes][:hourly_weather][0]).to have_key(:condition)
        expect(weather[:data][:attributes][:hourly_weather][0]).to have_key(:icon)
    end
end