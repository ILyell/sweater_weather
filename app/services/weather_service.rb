class WeatherService

    def conn 
        Faraday.new("http://api.weatherapi.com/v1/forecast.json") 
    end

    def get_url(url) 
        conn.get(url) do |r|
            r.headers["key"] = Rails.application.credentials.weather[:key]
        end
    end
    
    def get_forecast(lat,lon)
        response = get_url("?q=#{lat},#{lon}&days=5")
        JSON.parse(response.body, symbolize_names: true)
    end
end