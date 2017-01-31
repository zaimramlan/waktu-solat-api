class PrayerTime < ApplicationRecord
    # reference: http://joshfrankel.me/blog/2016/how-to/create-a-many-to-many-activerecord-association-in-ruby-on-rails/
    has_and_belongs_to_many :zones
end
