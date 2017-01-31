class Api::V1::PrayerTimesController < ApiController
    before_action :validate_params, :warn_if_params_empty, :downcase_params

    def index
        @prayer_times = PrayerTimesHelper.search_prayer_times(params)
        render_no_result and return if @prayer_times.empty?
        render_result(@prayer_times)
    end

    private

    def validate_params
        permit_only(['zon', 'negeri'])
    end
end
