class RouteTime

    attr_reader :current_time,
                :arrival_time,
                :arrival_date,
                :full_arrival_date

    def initialize(route_time)
        @current_time = DateTime.now
        @route_time_seconds = route_time
        @arrival_time = set_arrival_time
        @arrival_date = @arrival_time.strftime('%Y-%m-%d')
        @full_arrival_date = @arrival_time.strftime('%Y-%m-%d %H:%M')
    end

    def set_arrival_time 
        if @route_time_seconds != nil
            Time.at(@route_time_seconds).to_datetime
            arrival = @current_time + @route_time_seconds.seconds
            round_to_nearest_hour(arrival)
        end
    end

    def format_route_time
        if @route_time_seconds != nil && @route_time_seconds != 0
            seconds_to_time(@route_time_seconds)
        else
            "Travel is impossible!"
        end
    end

    def seconds_to_time(seconds)
        [seconds / 3600, seconds / 60 % 60, seconds % 60].map { |t| t.to_s.rjust(2,'0') }.join(':')
    end
    
    def round_to_nearest_hour(time)
        if time.minute >= 30
            t2 = time.at_end_of_hour.to_i + 1
            Time.at(t2).to_datetime
        else
            t2 = time.beginning_of_hour.to_i
            Time.at(t2).to_datetime
        end
    end
end