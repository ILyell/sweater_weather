class BaseFacade

    def geo_service
        @_geo ||= MapQuestService.new
    end

    def weather_service
        @_weather ||= WeatherService.new
    end
end