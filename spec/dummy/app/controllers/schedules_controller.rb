class SchedulesController < ApplicationController
	def new
		@schedule = Schedule.new
	end


	def edit
		@schedule = Schedule.find(params[:id])
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
										:sleepytime, :party_time, :easter)
	end
end