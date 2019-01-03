namespace :esolat do       
    namespace :v1 do
        desc 'scrape e-solat for MY zone codes'
        task :scrapezones => :environment do
            require 'helpers'
            include Helpers
            include Helpers::V1

            # destroy all existing records to prevent duplicates
            State.destroy_all
                
            puts '================== SCRAPING STARTED ==================='
            # initialise the hash to store the state and zones
            hash = Hash.new

            url  = 'http://www.e-solat.gov.my/web/my_waktusolat/index.php'
            page = Nokogiri::HTML(open(url))

            # retrieve the zone codes
            rows = page.css('option').to_a
            # remove the instruction
            rows = rows.reverse
            rows.pop

            rows.each do |row|
                data  = row.text.split('--')
                state = SanitizerHelper.sanitize_states(data[0]).downcase
                zones = SanitizerHelper.sanitize_zones(data[1].split('-').last).downcase
                code  = row.attribute('value').to_s.split(';').last.upcase

                hash[state] = Array.new if hash[state].nil?
                hash[state].push({
                    'code'  => code,
                    'zones' => zones
                })
            end

            # ap hash
            RecordsHelper.create_zones_from(hash)
            puts '================= SCRAPING FINISHED =================='
        end
    end
end
