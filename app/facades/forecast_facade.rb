class ForecastFacade < BaseFacade

    def initialize(params)
        @location = location_create(params)
        @forecast = forecast_create
    end

    def location_create(location)
        geo_loc = geo_service.get_geolocation(location)
        Location.new(geo_loc, location)
    end

    def forecast_create
        f = weather_service.get_forecast(@location.geo_loc[:lat], @location.geo_loc[:lng])
        Forecast.new(f)
    end

    def serialize
        ForecastSerializer.serialize(@forecast)
    end
end