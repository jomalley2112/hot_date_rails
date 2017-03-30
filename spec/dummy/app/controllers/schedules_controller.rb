class SchedulesController < ApplicationController

	def index
		@schedules = Schedule.all
	end

	def filter_schedules
		@start_date, @end_date = params[:start_date], params[:end_date]
		@schedules = Schedule.where(birthday: @start_date..@end_date)
	end

	def new
		@schedule = Schedule.new
	end


	def edit
		@schedule = Schedule.find(params[:id])
	end

	def edit_in_modal
		@schedule = Schedule.find(params[:id])
		render :edit, layout: false
	end

	def edit_with_index
		@schedule = Schedule.find(params[:id])
		@schedules = Schedule.all
	end

	def create
		@schedule = Schedule.new(schedule_params)
		if @schedule.save
			redirect_to edit_schedule_url(@schedule)
		else
			flash[:alert] = "Unable to save schedule"
			render :new
		end
	end

	def update
		@schedule = Schedule.find(params[:id])
		if @schedule.update_attributes(schedule_params)
			redirect_to edit_schedule_url(@schedule)
		else
			flash[:alert] = "Unable to save schedule"
			render :edit
		end
	end


	def new_custom
		@schedule = Schedule.new
	end

	def edit_custom
		@schedule = Schedule.find(params[:id])
	end


	private
	def schedule_params
		params.require(:schedule).permit(:name, :lunchtime, :apocalypse, 
										:birthday, :alarm_setting, :epoch, :christmas, :suppertime, :beer_oclock,
										:sleepytime, :party_time, :easter, :date_in_time)
	end
end