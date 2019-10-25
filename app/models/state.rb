class State < ApplicationRecord
    has_many :zones, dependent: :destroy

    def self.details
        array  = Array.new
        states = State.all.includes(:zones)
        states.each {|state| data = {name: state.name, zones: state.zones}; array.push(data)}

        array
    end

    def self.details_of(state_name)
        state  = State.find_by_name(state_name)
        if !state.nil?
            {
                name: state.name,
                zones: state.zones
            }
        end
    end    
end
