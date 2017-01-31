class CreatePrayerTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :prayer_times do |t|
      t.integer :zone_id
      t.string :name
      t.datetime :time

      t.timestamps
    end
  end
end
