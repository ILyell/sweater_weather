class WeatherService

    def conn 
        Faraday.new("http://api.weatherapi.com/v1") 
    end

    def get_url(url) 
        conn.get(url) do |r|
            r.headers["key"] = Rails.application.credentials.weather[:key]
        end
    end

    def get_forecast
        get_url("/current.json?q=29.9537,-90.07775")
    end
end