class AddTimeOfDateToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :time_of_date, :datetime
  end
end
