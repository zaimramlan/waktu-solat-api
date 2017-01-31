module StatesHelper
    def self.state_present?(params)
        !params['negeri'].nil?
    end

    def self.state_and_zones(params)
        state = State.find_by_name(params['negeri'])
        return {} if state.nil?
        return {negeri: {nama: state.name, zon: state.zones.pluck(:name)}}
    end

    def self.complete_states
        return {negeri: State.all.pluck(:name)}
    end

    def self.search_states(params)
        return state_and_zones(params) if state_present?(params)
        complete_states
    end
end
