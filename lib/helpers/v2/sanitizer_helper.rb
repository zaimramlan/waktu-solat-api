module Helpers
    module V2
        module SanitizerHelper
            def self.sanitize_states(str)
                str = str.gsub(/_/, ' ')
                str = str.strip
            end

            def self.sanitize_zones(str)
                # remove strings with ' dan '
                str = str.gsub(/[\u00a0\s]dan[\u00a0\s]/, ',')
                # convert string to Title Case
                str = str.titleize
                # remove all types of whitespaces
                str = str.gsub(/[\u00a0\s]/, '')
                # add spacing between exclusive names
                str = str.split(',').map {|s| s.split(/(?=[A-Z])/).join(' ')}.join(',')
                # align spacing with brackets
                str = str.split('(').map {|s| s.strip}.join(' (')
                # downcase string for accurate string replacement
                str = str.downcase
                # remove the word 'zon' and its number
                str = str.gsub(/[0-9]|zon/, '')
                # remove the word 'seluruh negeri'
                str = str.gsub(/seluruh negeri/, '')
                # remove beginning and ending whitespaces
                str = str.strip
            end

            def self.sanitize_prayer_name(name)
                name = name.downcase

                case name
                when 'fajr'  then return 'subuh'
                when 'dhuhr' then return 'zohor'
                when 'asr'   then return 'asar'
                when 'isha'  then return 'isyak'
                else return name
                end
            end

            def self.sanitize_prayer_time(time, name)
                # replace '.' with ':' character
                time = time.gsub(/[\.]+/, ':')
                # remove seconds
                time = time.split(':').first(2).join(':')

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
