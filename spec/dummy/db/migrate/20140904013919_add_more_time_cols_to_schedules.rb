class AddMoreTimeColsToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :suppertime, :time
    add_column :schedules, :beer_oclock, :time
    add_column :schedules, :sleepytime, :time
    add_column :schedules, :party_time, :time
  end
end
