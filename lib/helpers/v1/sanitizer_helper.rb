module Helpers
    module V1
        module SanitizerHelper
            def self.sanitize_states(str)
                str.gsub!(/_/, ' ')
                str.strip!
            end

            def self.sanitize_zones(str)
                # remove strings with ' dan '
                str.gsub!(/[\u00a0\s]dan[\u00a0\s]/, ',')
                # remove all types of whitespaces
                str.gsub!(/[\u00a0\s]/, '')
                # remove brackets
                str.gsub!(/[()]/, '')
                # remove the word 'Zon' and its number
                str.gsub!(/[0-9]|Zon/, '') if str.downcase.include? "zon"
                # add spacing between exclusive names
                str = str.split(',').map! {|s| s.split(/(?=[A-Z])/).join(' ');}
                # join all strings back with comma
                str = str.join(',')
            end

            def self.sanitize_prayer_time(time, name)
                # replace '.' with ':' character
                time = time.gsub(/[\.]+/, ':')

                # in the case of these prayer times are at incorrect hours,
                # offset them into the correct time
                case name
                when 'zohor', 'asar', 'maghrib', 'isyak'
                    prayer_time = Time.parse(time)

                    if prayer_time.period == 'am'
                        prayer_time += 12.hours
                        return prayer_time.in_international_time
                    end
                end

                return time
            end
        end
    end
end
