class CreatePrayerTimesZones < ActiveRecord::Migration[5.0]
  def change
    create_table :prayer_times_zones do |t|
      t.references :zone, foreign_key: true
      t.references :prayer_time, foreign_key: true
    end
  end
end
