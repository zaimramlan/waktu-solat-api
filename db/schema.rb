# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2017_01_14_094404) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "prayer_times", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prayer_times_zones", id: :serial, force: :cascade do |t|
    t.integer "zone_id"
    t.integer "prayer_time_id"
    t.index ["prayer_time_id"], name: "index_prayer_times_zones_on_prayer_time_id"
    t.index ["zone_id"], name: "index_prayer_times_zones_on_zone_id"
  end

  create_table "states", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zones", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "state_id"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "prayer_times_zones", "prayer_times"
  add_foreign_key "prayer_times_zones", "zones"
end
