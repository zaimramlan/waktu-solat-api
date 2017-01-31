module ZonesHelper
    def self.zone_present?(params)
        !params['zon'].nil?
    end

    def self.zones(params)
        zone  = Zone.find_by_name(params['zon'])
        return {} if zone.nil?
        return {negeri: zone.state.name, zon: zone.name}
    end

    def self.complete_zones
        return {zon: Zone.all.pluck(:name)}
    end

    def self.search_zones(params)
        return zones(params) if zone_present?(params)
        complete_zones
    end
end
