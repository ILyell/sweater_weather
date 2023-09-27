class RoadTripSerializer

    def initialize(origin,destination,time,forecast)
        @origin = origin
        @destination = destination
        @time = time
        @forecast = forecast
    end

    def serialize
        { 
            data: {
                id: 'null',
                type: 'road_trip',
                attributes: {
                    start_city: @origin.location,
                    end_city: @destination.location,
                    travel_time: @time.format_route_time,
                    weather_at_eta: @forecast.arrival_forecast
                }
            }
        }
    end
end
