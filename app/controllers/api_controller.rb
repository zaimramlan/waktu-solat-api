class ApiController < ApplicationController
    def filtered_params
        params.except(:controller, :action, :format)
    end

    def key_permitted?(array, key)
        array.include?(key)
    end

    def nil_empty_or_blank?(object)
        object.nil? || object.empty? || object.blank?
    end

    def permit_only(array)
        filtered_params.each {|key, value| render_unpermitted and return if !key_permitted?(array, key)}
    end

    def warn_if_params_empty
        filtered_params.each {|key, value| render_param_empty(key) and return if nil_empty_or_blank?(value) }
    end

    def render_unpermitted
        render :json => {error: "Unpermitted parameters"}, 
                        status: :bad_request
    end    

    def render_param_empty(key)
        render :json => {error: "#{key} parameter value is empty"}, 
                        status: :bad_request
    end

    def render_result(data)
        render :json => {data: data, about: about}, except: [:id, :created_at, :updated_at], 
                        status: :ok
    end

    def render_no_result
        render :json => {data: [], message: "No results found", about: about},
                        status: :ok
    end

    def downcase_params
        params.each {|key, value| value.downcase!} 
    end

    def about
        {
            github:     "https://github.com/zaimramlan/waktu-solat-api",
            source:     "http://www.e-solat.gov.my",
            created_by: "Zaim Ramlan"
        }
    end
end
