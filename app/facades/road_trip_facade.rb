class RoadTripFacade < BaseFacade

    def initialize(params)
        @origin = location_create(params[:origin])
        @destination = location_create(params[:destination])
        @time = time_create
        @forecast = forecast_create
    end

    def location_create(location)
        geo_loc = geo_service.get_geolocation(location)
        Location.new(geo_loc, location)
    end

    def time_create
        route_time = geo_service.get_route_time(@origin.location, @destination.location)
        RouteTime.new(route_time)
    end

    def forecast_create
        forecast = weather_service.get_forecast_at_date(@destination.geo_loc[:lat],@destination.geo_loc[:lng], @time.arrival_date)
        Forecast.new(forecast, @time.full_arrival_date)
    end

    def serialize
        RoadTripSerializer.serialize(@origin,@destination,@time,@forecast)
    end
end