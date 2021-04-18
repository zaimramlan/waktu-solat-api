namespace :esolat do
    namespace :v2 do
        desc 'scrape e-solat for daily solat times'
        task :scrapetimes => :environment do
            require 'helpers'
            include Helpers
            include Helpers::V2

            # destroy all existing records to prevent duplicates
            PrayerTime.destroy_all

            puts '================== SCRAPING STARTED ==================='
            zone_codes = Zone.codes
            hash       = Hash.new

            zone_codes.each do |code|
                puts 'SCRAPING ZONE: ' + code

                url = ENV['MAIN_PRAYER_TIMES_URL'] + code
                response = perform_request(url)

                data = response.parsed_response['prayerTime'].first
                prayer_times = Hash.new

                data.each do |name, time|
                    next if !is_a_prayer(name)
                    prayer_name = SanitizerHelper.sanitize_prayer_name(name)
                    prayer_time = time
                    prayer_times[prayer_name] = SanitizerHelper.sanitize_prayer_time(prayer_time, prayer_name)
                end

                hash[code] = prayer_times
            end

            # ap hash
            RecordsHelper.create_prayer_times_from(hash)
            puts '================= SCRAPING FINISHED =================='
        end

        def perform_request(url)
            begin
                response = HTTParty.get(url)
            rescue
                response = perform_request(url)
            end

            return response
        end

        def is_a_prayer(name)
            case name
            when "imsak", "fajr", "syuruk", "dhuhr", "asr", "maghrib", "isha"
                return true
            else
                return false
            end
        end
    end
end
