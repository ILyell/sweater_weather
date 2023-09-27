class RoadTripSerializer < ForecastSerializer

    def initialize(params)
        @loc_1 = params[:origin]
        @loc_2 = params[:destination]
        @time = DateTime.now
        @route_time = geo_service.get_route_time(@loc_1, @loc_2)
        @arrival_time = Time.at(arrival_time).to_datetime
        @forecast = get_trip_forcast
    end

    def serialize
        { 
            data: {
                id: 'null',
                type: 'road_trip',
                attributes: {
                    start_city: @loc_1,
                    end_city: @loc_2,
                    travel_time: travel_time,
                    weather_at_eta: {
                        datetime: @forecast[:time],
                        temperature: @forecast[:temp_f],
                        condition: @forecast[:condition][:text]
                    }
                }
            }
        }
    end

    def get_trip_forcast
        geo = geo_service.get_geolocation(@loc_2)
        weather = weather_service.get_forecast_at_date(geo[:lat], geo[:lon], @arrival_time.strftime('%Y-%m-%d'))
        weather[:forecast][:forecastday][0][:hour].find do |hour|
            hour[:time] = @arrival_time.strftime('%Y-%m-%d %H:%M')
        end
    end

    def travel_time
        if @route_time != 0
            seconds_to_time(@route_time)
        else
            "Travel is impossible!"
        end
    end

    def seconds_to_time(seconds)
        [seconds / 3600, seconds / 60 % 60, seconds % 60].map { |t| t.to_s.rjust(2,'0') }.join(':')
    end

    def arrival_time
        arrival = @time + @route_time.seconds
        if arrival.minute >= 30
            arrival.at_end_of_hour.to_i + 1
        else
            arrival.beginning_of_hour.to_i
        end
    end
end
