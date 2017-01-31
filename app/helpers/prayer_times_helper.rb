module PrayerTimesHelper
    def self.present?(object)
        !object.nil?
    end

    def self.zone_and_state_present?(params)
        params['zon'] && params['negeri']
    end

    def self.zone_or_state_present?(params)
        params['zon'] || params['negeri']
    end

    def self.build_result(state = nil, zones = nil)
        array = Array.new

        if state.present?
            zones = state.zones if zones.nil?
            zones.each {|zone| array.push({nama: zone.name, waktu_solat: zone.prayer_times})}
            {
                negeri: state.name,
                zon: array
            }
        else
            zones.each {|zone| array.push({negeri: zone.state.name, zon: zone.name, waktu_solat: zone.prayer_times})}
            array
        end
    end

    def self.in_zone_and_state(params)
        state    = State.find_by_name(params['negeri'])
        return {} if state.nil?

        zone     = '%'+params['zon']+'%'
        zones    = state.zones.where("name LIKE ? AND state_id = ?", zone, state.id)
        return {} if zones.empty?
        return build_result(state, zones)        
    end

    def self.in_zone_or_state(params)
        if params['zon'].present?
            zone     = '%'+params['zon']+'%'
            zones    = Zone.where("name LIKE ?", zone).order(:state_id)
            return {} if zones.empty?
            return build_result(nil, zones)

        elsif params['negeri'].present?
            state    = State.find_by_name(params['negeri'])
            return {} if state.nil?
            return build_result(state)
        end
    end

    def self.complete_prayer_times
        result = Array.new
        states = State.all

        states.each do |state|
            zone_arr = Array.new
            zones    = state.zones
            zones.each {|zone| zone_arr.push({nama: zone.name, waktu_solat: zone.prayer_times})}
            result.push({nama: state.name, zon: zone_arr})
        end

        return {negeri: result}
    end

    def self.search_prayer_times(params)
        return in_zone_and_state(params) if zone_and_state_present?(params)
        return in_zone_or_state(params)  if zone_or_state_present?(params)
        complete_prayer_times
    end    
end
