class AddEasterToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :easter, :date
  end
end
