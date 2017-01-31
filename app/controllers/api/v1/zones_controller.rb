class Api::V1::ZonesController < ApiController
    before_action :validate_params, :warn_if_params_empty, :downcase_params

    def index
        @zones = ZonesHelper.search_zones(params)
        render_no_result and return if @zones.empty?
        render_result(@zones)
    end

    private

    def validate_params
        permit_only(['zon'])
    end    
end
