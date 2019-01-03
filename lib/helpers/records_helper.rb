module Helpers
    module RecordsHelper
        def self.create_zones_from(hash)
            # for reference, hash will come like the form below:
            # 
            # {
            #     "state 1" => [
            #         [0] {
            #              "code" => "ST01",
            #             "zones" => "zone 1, zone 2, zone 3"
            #         },
            #         [1] {
            #              "code" => "ST02",
            #             "zones" => "zone 1, zone 2"
            #         }
            #     ],
            #     "state 2" => [
            #         [0] {
            #              "code" => "ST01",
            #             "zones" => "zone 1"
            #         },
            #         [1] {
            #              "code" => "ST02",
            #             "zones" => "zone 1, zone 2, zone 3, zone 4, zone 5"
            #         }
            #     ],        
            # }

            # remove previous records
            # this will destroy Zones as well since it's set 
            # to be dependent
            State.destroy_all

            hash.each do |state_name, zone_details|
                state = State.create(name: state_name)

                zone_details.each do |detail|
                    # split zone string to capture a single zone name
                    zones = detail['zones'].split(',')
                    # create a zone record for each zone names
                    zones.each {|zone| state.zones.create(name: zone, code: detail['code'])}
                end
            end
        end

        def self.create_prayer_times_from(hash)
            # for reference, hash will come like the form below:
            # 
            # {
            #     "ST01" => {
            #           "imsak" => "5:49",
            #           "subuh" => "5:59",
            #          "syuruk" => "7:21",
            #           "zohor" => "13:19",
            #            "asar" => "16:41",
            #         "maghrib" => "19:15",
            #           "isyak" => "20:28"
            #     },
            #     "ST02" => {
            #           "imsak" => "5:01",
            #           "subuh" => "5:11",
            #          "syuruk" => "6:32",
            #           "zohor" => "12:30",
            #            "asar" => "15:52",
            #         "maghrib" => "18:24",
            #           "isyak" => "19:38"
            #     }
            # }

            # remove previous prayer times records
            PrayerTime.destroy_all

            hash.each do |zone_code, prayer_times|
                # find the zones with corresponding zone codes
                zones = Zone.where(code: zone_code)

                prayer_times.each do |name, time|
                    # ensure prayer time is in proper international format
                    time   = Time.parse(time).strftime("%H:%M")
                    # create prayer time record
                    prayer = PrayerTime.create(name: name, time: time)
                    # tie prayer time record to corresponding zones
                    prayer.zones << zones
                end
            end
        end
    end
end
