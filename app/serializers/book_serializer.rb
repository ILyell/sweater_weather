class BookSerializer

    def initialize(params)
        @location = params[:location]
        @geo = geo_service.get_geolocation(@location)
        @weather = weather_service.get_forecast(@geo[:lat], @geo[:lng])
        @books = library_service.book_search(@location, params[:quantity])

    end

    def geo_service
        @_geo ||= MapQuestService.new
    end

    def weather_service
        @_weather ||= WeatherService.new
    end

    def library_service
        @_library ||= OpenLibraryService.new
    end

    def serialize
        {
            data: {
                id: "null",
                type: "books",
                attributes: {
                    destination: @location,
                    forecast: { 
                        summary: @weather[:current][:condition][:text],
                        temperature: @weather[:current][:temp_f],
                    },
                    total_books_found: @books[:numFound],
                    books: book_serialize
                }
            }
        }
    end

    def book_serialize
        @books[:docs].map do |book|
            {
                title: book[:title],
                isbn: book[:isbn]
            }
        end
    end
end