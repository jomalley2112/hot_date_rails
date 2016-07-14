class PeopleController < ApplicationController

	def edit
		@person = Person.find(params[:id])
	end

end