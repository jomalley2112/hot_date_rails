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

	def schedule_params
		params.require(:schedule).permit(:name, :lunchtime, :apocalypse, :birthday)
	end
end