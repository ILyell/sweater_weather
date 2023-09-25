class ForecastSerializer
    def initialize(params)
        @city = params[:city]
        @state = params[:state]
        @geo = geo_service.get_geolocation(@city, @state)
        @weather = weather_service.get_forecast(@geo[:lat], @geo[:lng])
    end

    def serialize
        {
            data: {
                id: "null",
                type: "forecast",
                attributes: {
                    current_weather: current_weather,
                    daily_weather: daily_weather,
                    hourly_weather: hourly_weather
                }
            }
        }
    end 

    def geo_service
        @_geo ||= MapQuestService.new
    end

    def weather_service
        @_weather ||= WeatherService.new
    end

    def current_weather
        {
            last_updated: @weather[:current][:last_updated],
            temperature: @weather[:current][:temp_f],
            feels_like: @weather[:current][:feelslike_f],
            humidity: @weather[:current][:humidity],
            uvi: @weather[:current][:uv],
            visibility: @weather[:current][:vis_miles],
            condition: @weather[:current][:condition][:text],
            icon: @weather[:current][:condition][:icon]
        }
    end

    def daily_weather
        @weather[:forecast][:forecastday][0..4].map do |day|
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
        @weather[:forecast][:forecastday][0][:hour].map do |hour|
            {
                time: hour[:time],
                temperature: hour[:temp_f],
                condition: hour[:condition][:text],
                icon: hour[:condition][:icon]
            }
        end
    end
end