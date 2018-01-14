module DateTimeExtensions
    module TIME_HELPERS
        # returns the datetime object as 
        # Day, Date Full-Month Full-Year
        def in_day_date
            self.strftime("%A, %d %B %Y")
        end
                
        # returns the datetime object as 
        # Hours:Minutes am/pm
        def in_standard_time
            self.strftime("%I:%M %P")
        end

        # returns the datetime object as 
        # Hours:Minutes
        def in_international_time
            self.strftime("%H:%M")
        end

        # returns the period of the time (am/pm)
        def period
            self.strftime("%P")
        end
    end    
end

class ActiveSupport::TimeWithZone
    include DateTimeExtensions::TIME_HELPERS
end

class Date
    include DateTimeExtensions::TIME_HELPERS
end

class Time
    include DateTimeExtensions::TIME_HELPERS
end
