require 'spec_helper'

RSpec.describe "Modal Dialog", :type => :request do
	context "when input is on a modal dialog" do
		let!(:schedule) { FactoryGirl.create(:schedule) }
		before { visit schedules_path }
		it "performs no differently", js: true do
			click_link("Edit")
			sleep 2
			find("#birthday").click
    	page.should have_selector("#ui-datepicker-div", visible: true)
		end
	end
end