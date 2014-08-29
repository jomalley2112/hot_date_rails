require 'spec_helper'

RSpec.describe "ScheduleSpecs", :type => :request do
  describe "Create New", :js => true do
    before(:each) do
  	  visit new_schedule_path
  	end
    describe "Date Picker" do
    	it "is displayed when date field receives focus and hidden 
    				when date field loses focus" do
	    	find("#birthday_vis").click
	    	page.should have_selector("#ui-datepicker-div", visible: true)
	    	find("#schedule_name").click
	    	page.should have_no_selector("#ui-datepicker-div", visible: true)
	    end
	    
	    it "fills in the date field correctly and disappears when day is clicked" do
	    	curr_date = Time.now
	    	find("#birthday_vis").click
	    	find("select.ui-datepicker-month").select("Jan")
	    	click_link("1")
	    	sleep 1
	    	find("#birthday_vis").value.should eq "01/01/#{curr_date.year}"
	    end
	  end

	  describe "Time Picker" do
	    it "is displayed when time field receives focus and is hidden 
	  				when time field loses focus" do
	    	find("#lunchtime_vis").click
	    	page.should have_selector("#ui-datepicker-div", visible: true)
	    	find("#schedule_name").click
	    	sleep 1
	    	page.should have_no_selector("#ui-datepicker-div", visible: true)
	    end
	    
	    it "fills in  the time field correctly and disappears when 'Done' button clicked" do
	    	find("#lunchtime_vis").click
	    	#find("select[data-unit='hour']").select("13")
	    	#find("select[data-unit='minute']").select("15")
	    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(62, 0) #1 pm
	    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(27, 0) #15 min
	    	find("button.ui-datepicker-close").click
	    	find("#lunchtime_vis").value.should eq "13:15"
	    end
	  end

	  describe "Datetime Picker" do
	    it "is displayed when datetime field receives focus and hidden 
	  				when datetime field loses focus" do
	    	find("#apocalypse_vis").click
	    	page.should have_selector("#ui-datepicker-div", visible: true)
	    	find("#schedule_name").click
	    	sleep 1
	    	page.should have_no_selector("#ui-datepicker-div", visible: true)
	    end
	    
	    it "fills in the datetime field correctly and disappears when 'Done' button clicked" do
	    	find("#apocalypse_vis").click
	    	curr_date = Time.now
	    	click_link("1")
	    	click_link("1")
	    	# find("select[data-unit='hour']").select("13")
	    	# find("select[data-unit='minute']").select("14")
	    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(62, 0) #1 pm
	    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(27, 0) #15 min
	    	find("button.ui-datepicker-close").click
	    	find("#apocalypse_vis").value
	    		.should eq "#{'%02i' % curr_date.month}/01/#{curr_date.year} 13:15"
	    end
	  end
  end
  
  describe "Update Existing" do
    
  end
end
