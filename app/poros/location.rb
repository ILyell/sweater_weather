class Location

    attr_reader :geo_loc, :location

    def initialize(geo_loc, location)
        @geo_loc = geo_loc
        @location = location
    end
end