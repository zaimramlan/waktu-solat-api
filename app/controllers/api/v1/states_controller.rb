class Api::V1::StatesController < ApiController
    before_action :validate_params, :warn_if_params_empty, :downcase_params

    def index
        @states = StatesHelper.search_states(params)
        render_no_result and return if @states.empty?
        render_result(@states)
    end

    private

    def validate_params
        permit_only(['negeri'])
    end
end
