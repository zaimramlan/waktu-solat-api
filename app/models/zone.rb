class Zone < ApplicationRecord
    belongs_to :state
    has_and_belongs_to_many :prayer_times

    # get zone codes
    scope :codes, -> { (select(:code).group(:code).pluck(:code)).sort }
end
