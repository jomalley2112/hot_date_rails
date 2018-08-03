require 'spec_helper'

RSpec.describe "Dynamically added inputs", :type => :request do
	context "when input is on a modal dialog", js: true do
		let!(:schedule) { FactoryGirl.create(:schedule) }
		it "performs no differently" do
			visit schedules_path
			find("body").click
			click_link("Edit")
			sleep 2
			find("#schedule_birthday").click
    	page.should have_selector("#ui-datepicker-div", visible: true)
		end
		
		describe "both static and dynamic inputs" do
			context "...and there's a picker in the document behind the modal" do
				before do 
					visit edit_schedule_with_index_path(schedule)
					find("body").click
				end
				it "has no adverse effect on the non-dynamically added fields" do
					click_link "Edit" #open modal (which kicks off call to Window.bindHDPickers
					sleep 2
					click_button("Close") #close modal
					sleep 1
					find("#schedule_birthday").click
					page.should have_selector("#ui-datepicker-div", visible: true)
				end
			end
		end
		
	end
end