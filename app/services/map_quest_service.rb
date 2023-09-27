class MapQuestService

    def conn 
        Faraday.new("https://www.mapquestapi.com")
    end

    def get_url(url) 
        conn.get(url) do |response|
            response.headers["key"] = Rails.application.credentials.map_quest[:key]
        end
    end

    def post_url(url, body)
        conn.post(url) do |r|
            r.headers["key"] = Rails.application.credentials.map_quest[:key]
            r.body = JSON.generate(body)
        end
    end

    def get_geolocation(location)
        response = get_url("/geocoding/v1/address?location=#{location}")
        body = JSON.parse(response.body, symbolize_names: true)
        body[:results][0][:locations][0][:latLng]
    end

    def get_route_time(loc_1, loc_2)
        body = { locations: [loc_1, loc_2] }
        response = post_url("https://www.mapquestapi.com/directions/v2/routematrix", body)
        body = JSON.parse(response.body, symbolize_names: true)
        body[:time][1]
    end
end