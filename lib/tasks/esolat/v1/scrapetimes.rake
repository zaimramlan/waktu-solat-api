namespace :esolat do
    namespace :v1 do
        desc 'scrape e-solat for daily solat times'
        task :scrapetimes => :environment do
            require 'helpers'
            include Helpers
            include Helpers::V1

            # destroy all existing records to prevent duplicates
            PrayerTime.destroy_all        

            puts '================== SCRAPING STARTED ==================='
            zone_codes       = Zone.codes
            hash             = Hash.new

            zone_codes.each do |code|
                url          = 'http://www.e-solat.gov.my/web/my_waktusolat/mod_waktusolatget.php?negeri=;;;;;' + code
                page         = Nokogiri::HTML(open(url))

                # find relevant row entries, capture text and remove whitespaces, linebreaks
                rows         = page.css('b').map { |row| row.text.to_s.gsub(/[\s\n]/, '') }
                # remove empty array element and reverse the array
                rows         = rows.reject(&:empty?).reverse
                # remove the rows that should contain the zone name, latitude and longitude
                rows.pop
                rows.pop    if rows.last =~ /[0-9\u00B0]+/
                # re-reverse the row entries
                rows         = rows.reverse

                prayer_times = Hash.new
                # pluck even indexes
                name_indexes = rows.each_index.select {|i| i.even?}
                # pluck odd indexes
                time_indexes = rows.each_index.select {|i| i.odd?}

                for i in 0..name_indexes.length-1
                    prayer_name               = rows[name_indexes[i].to_i].downcase
                    prayer_time               = rows[time_indexes[i].to_i]
                    prayer_times[prayer_name] = SanitizerHelper.sanitize_prayer_time(prayer_time, prayer_name)
                end

                hash[code] = prayer_times
            end

            # ap hash
            RecordsHelper.create_prayer_times_from(hash)
            puts '================= SCRAPING FINISHED =================='
        end
    end
end
