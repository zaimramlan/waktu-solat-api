namespace :esolat do       
    namespace :v2 do
        desc 'scrape e-solat for MY zone codes'
        task :scrapezones => :environment do
            require 'helpers'
            include Helpers
            include Helpers::V2

            # destroy all existing records to prevent duplicates
            State.destroy_all
                
            puts '================== SCRAPING STARTED ==================='
            # initialise the hash to store the state and zones
            hash = Hash.new

            url  = ENV['MAIN_ZONE_URL']
            page = perform_open(url)

            # retrieve the zone codes
            rows = page.css('optgroup').to_a

            rows.each do |state|
                state_name = SanitizerHelper.sanitize_states(state.attribute('label').text).downcase

                zones = state.children.to_a
                zones.each do |zone|
                    data  = zone.text.split('-').last
                    zones = SanitizerHelper.sanitize_zones(data).downcase
                    code  = zone.attribute('value').text.upcase

                    hash[state_name] = Array.new if hash[state_name].nil?
                    hash[state_name].push({
                        'code'  => code,
                        'zones' => zones
                    })
                end
            end

            # ap hash
            RecordsHelper.create_zones_from(hash)
            puts '================= SCRAPING FINISHED =================='
        end

        def perform_open(url)
            begin
                page = Nokogiri::HTML(open(url))
            rescue
                page = perform_open(url)
            end

            return page
        end
    end
end
