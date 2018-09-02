namespace :esolat do
  namespace :backup do
    desc 'scrape e-solat backup for zones'
    task :scrapezones => :environment do
      require 'sanitizer_helper'
      require 'records_helper'

      # destroy all existing records to prevent duplicates
      State.destroy_all
          
      puts '================== SCRAPING STARTED ==================='
      
      # initialise the hash to store the state and zones
      hash = Hash.new

      # query & parse states
      url  = ENV['BACKUP_ZONE_URL']
      resp = HTTParty.get(url)
      resp = JSON.parse(resp.body)
      states = resp['states'].map { |s| s.downcase }

      states.each do |state|
        # query & parse zones filtered by state
        url   = "#{ENV['BACKUP_ZONE_URL']}?state=#{state}"
        resp  = HTTParty.get(url)
        resp  = JSON.parse(resp.body)
        resp  = resp['results']

        zones = ''
        code  = ''
        resp.each do |zone|
          zones  = code != zone['zone'] ? "" : "#{zones},"
          zones += "#{zone['lokasi'].downcase}"
          code   = zone['zone']

          index = resp.index(zone) + 1
          next if resp.count != index && resp[index]['zone'] == code

          hash[state] = Array.new if hash[state].nil?
          hash[state].push({
              'code'  => code,
              'zones' => zones
          })
        end
        
        # ap state
        # ap hash[state]
      end

      # ap hash
      RecordsHelper.create_zones_from(hash)
      puts '================= SCRAPING FINISHED =================='
    end
  end
end
