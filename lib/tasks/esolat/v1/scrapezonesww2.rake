namespace :esolat do
    namespace :v1 do
        desc 'scrape e-solat for MY zone codes'
        task :scrapezonesww2 => :environment do
            require 'helpers'
            include Helpers
            
            puts '================== SCRAPING STARTED ==================='.green

            first_page = '1'
            base_url   = 'http://www2.e-solat.gov.my/zon-waktusolat.php?PageNo='
            url        = base_url + first_page 
            page       = Nokogiri::HTML(open(url))

            # dynamically retrieve the last page
            rows       = page.css('div[align=right]').first # page 1 from N
            last_page  = rows.text.split('from').second.to_s.strip

            # initialise the hash to store the state and zones
            hash       = Hash.new        

            for i in first_page.to_i..last_page.to_i
                puts "PAGE #{i} of #{last_page}".yellow

                # skip opening the first page
                # since we've opened the first page, above
                if i != first_page.to_i
                    url     = base_url + i.to_s 
                    page    = Nokogiri::HTML(open(url))
                end

                # retrieve the zone codes
                rows = page.xpath('//tr[starts-with(@bgcolor, "#FFF")]')

                rows.each do |row|
                    data    = row.css('td').to_a
                    state   = sanitize(data[1].text, 'state').downcase
                    zones   = sanitize(data[2].text).titleize.downcase
                    code    = sanitize(data[3].text).upcase

                    hash[state] = Array.new if hash[state].nil?
                    hash[state].push({
                        'code'  => code,
                        'zones' => zones
                    })
                end
            end

            ap hash
            RecordsHelper.create_zones(hash)
            puts '================= SCRAPING FINISHED =================='.green        
        end

        def sanitize(str, type=nil)
            # remove Unicode and ASCII whitespaces, linebreaks
            str.gsub!(/[\u00a0\s\n]/, '') 

            # replace underscores with a whitespace
            str.gsub!(/_/, ' ')

            # add a whitespace between states were title-ised
            str = str.split(/(?=[A-Z])/).join(' ') if type == 'state' && str != str.upcase
            
            # remove the word 'zon' and numbers from zone names
            return str.downcase.gsub!(/[0-9]|zon/, '') if str.downcase.include? "zon"
            str
        end
    end
end
