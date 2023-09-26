class OpenLibraryService

    def conn 
        Faraday.new("https://openlibrary.org")
    end

    def get_url(url) 
        conn.get(url)
    end

    def book_search(search, quantity)
        response = get_url("/search.json?q=#{search}&limit=#{quantity}")
        JSON.parse(response.body, symbolize_names: true)
    end
end