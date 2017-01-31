Rails.application.routes.draw do
    root to: redirect('/api/v1/prayer_times.json?negeri=selangor')

    namespace :api do
        namespace :v1 do
            resources :states, only: :index
            resources :zones, only: :index
            resources :prayer_times, only: :index
        end
    end
end
