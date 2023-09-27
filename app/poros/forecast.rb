class Forecast

    attr_reader :forecast,
                :current_weather,
                :daily_weather,
                :hourly_weather,
                :arrival_forecast

    def initialize(forecast, arrival_time = nil)
        @forecast = forecast
        @current_weather = current_weather
        @daily_weather = daily_weather
        @hourly_weather = hourly_weather
        @arrival_time = arrival_time
        @arrival_forecast = arrival_forecast
    end

    def current_weather
        {
            last_updated: @forecast[:current][:last_updated],
            temperature: @forecast[:current][:temp_f],
            feels_like: @forecast[:current][:feelslike_f],
            humidity: @forecast[:current][:humidity],
            uvi: @forecast[:current][:uv],
            visibility: @forecast[:current][:vis_miles],
            condition: @forecast[:current][:condition][:text],
            icon: @forecast[:current][:condition][:icon]
        }
    end

    def daily_weather
        @forecast[:forecast][:forecastday][0..4].map do |day|
            {
                date: day[:date],
                sunrise: day[:astro][:sunrise],
                sunset: day[:astro][:sunset],
                max_temp: day[:day][:maxtemp_f],
                min_temp: day[:day][:mintemp_f],
                condition: day[:day][:condition][:text],
                icon: day[:day][:condition][:icon]
            }
        end
    end

    def hourly_weather
        @forecast[:forecast][:forecastday][0][:hour].map do |hour|
            {
                time: hour[:time],
                temperature: hour[:temp_f],
                condition: hour[:condition][:text],
                icon: hour[:condition][:icon]
            }
        end
    end

    def arrival_forecast
        if @arrival_time != nil
            forecast = @forecast[:forecast][:forecastday][0][:hour].find do |hour|
                hour[:time] == @arrival_time
            end
            {
                datetime: forecast[:time],
                temperature: forecast[:temp_f],
                condition: forecast[:condition][:text]
            }
        else
            {
                datetime: @current_weather[:datetime],
                temperature: @current_weather[:temperature],
                condition: @current_weather[:condition]
            }
        end
    end
end