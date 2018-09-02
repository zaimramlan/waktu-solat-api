namespace :esolat do
  namespace :backup do
    desc 'scrape e-solat backup for daily solat times'
    task :scrapetimes => :environment do
      require 'records_helper'
      require 'sanitizer_helper'
      $stdout.sync = true

      # destroy all existing records to prevent duplicates
      PrayerTime.destroy_all        

      puts '================== SCRAPING STARTED ==================='
      hash       = Hash.new
      zone_codes = Zone.codes

      zone_codes.each do |code|
        print "----> Scraping zone: #{code}"

        # query and parse prayer times
        url  = ENV['BACKUP_PRAYER_TIMES_URL'] + "?format=24-hour&zone=#{code}"
        resp = HTTParty.get(url)
        resp = JSON.parse(resp.body)
        resp = resp['prayer_times']
          
        # remove unnecessary keys
        keys = resp.keys
        resp = resp.except(keys[0], keys[1])

        # store prayer times
        prayer_times = Hash.new
        resp.each do |name, time|
          prayer_times[name] = time
        end

        hash[code] = prayer_times
        puts ' [Scraped]'
      end

      # ap hash
      RecordsHelper.create_prayer_times_from(hash)
      puts '================= SCRAPING FINISHED =================='
    end
  end
end
