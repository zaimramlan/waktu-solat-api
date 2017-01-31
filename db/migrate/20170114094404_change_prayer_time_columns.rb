class ChangePrayerTimeColumns < ActiveRecord::Migration[5.0]
    def up
        remove_column :prayer_times, :zone_id
        change_column :prayer_times, :time, :string
    end

    def down
        add_column :prayer_times, :zone_id
        change_column :prayer_times, :time, :datetime
    end
end
