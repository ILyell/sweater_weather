class MapQuestService

    def conn 
        Faraday.new("https://www.mapquestapi.com")
    end

    def get_url(url) 
        conn.get(url) do |response|
            response.headers["key"] = Rails.application.credentials.map_quest[:key]
        end
    end

    def get_geolocation(city,state)
        response = get_url("/geocoding/v1/address?location=#{city}, #{state}")
        body = JSON.parse(response.body, symbolize_names: true)
        binding.pry
        body[:results][0][:locations][0][:latLng]
    end
end