require 'spec_helper'

RSpec.describe "Picker Microdata Customization", :type => :request do
	before(:each) do
	  visit '/custom_schedules/new'
	end
	describe "Date Picker" do
	  
	end

	describe "Time Picker", :js => true do
		before(:each) do
		  find("input#lunchtime").click
		end
	  describe "add or change text" do
	  	it "allows us to specify the text of the 'Now' button" do
	  		find("button.ui-datepicker-current").text.should eq "Current"
	  	end
	  	it "allows us to set the text on the Done button" do
	  		find("button.ui-datepicker-close").text.should eq "Set"
	  	end
	  	it "allows us to add a suffix after the time displayed" do
	  		find("dd.ui_tpicker_time").text.should match(/.*\so\'clock/)
	  	end
	  end
	end

	describe "Datetime Picker" do
	  
	end

end