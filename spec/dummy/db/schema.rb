# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141101193750) do

  create_table "schedules", force: true do |t|
    t.string   "name"
    t.date     "birthday"
    t.time     "lunchtime"
    t.datetime "apocalypse"
    t.datetime "epoch"
    t.date     "christmas"
    t.time     "alarm_setting"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "suppertime"
    t.time     "beer_oclock"
    t.time     "sleepytime"
    t.time     "party_time"
    t.date     "easter"
    t.datetime "date_in_time"
    t.datetime "time_of_date"
  end

end
