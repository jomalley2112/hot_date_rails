class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :name
      t.date :birthday
      t.time :lunchtime
      t.datetime :apocalypse
      t.datetime :epoch
      t.date :christmas
      t.time :alarm_setting

      t.timestamps
    end
  end
end
