require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# configure figaro here
Figaro.configure {|config| config.ignore_warnings = true}

module WaktuSolatApi
    class Application < Rails::Application
        # Settings in config/environments/* take precedence over those specified here.
        # Application configuration should go into files in config/initializers
        # -- all .rb files in that directory are automatically loaded.
        config.time_zone = 'Asia/Kuala_Lumpur'
        config.action_dispatch.default_headers = {
            'Access-Control-Allow-Origin' => '*'
        }

        # Auto-load pre-defined Ruby/Rails class extensions
        config.autoload_paths += Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each {|l| require l}
    end
end
