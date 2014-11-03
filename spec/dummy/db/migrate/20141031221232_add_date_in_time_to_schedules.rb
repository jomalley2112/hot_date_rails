class AddDateInTimeToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :date_in_time, :datetime
  end
end
