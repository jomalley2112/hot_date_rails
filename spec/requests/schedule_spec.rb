require 'spec_helper'

RSpec.describe "Schedule", :type => :request do
  describe "Create New", :js => true do
    before(:each) do
  	  visit new_schedule_path
  	end
    describe "Date Picker" do
    	it "is displayed when date field receives focus and hidden 
    				when date field loses focus" do
	    	find("#birthday").click
	    	page.should have_selector("#ui-datepicker-div", visible: true)
	    	find("#schedule_name").click
	    	page.should have_no_selector("#ui-datepicker-div", visible: true)
	    end
	    
	    it "fills in the date field correctly and disappears when day is clicked" do
	    	curr_date = Time.now
	    	find("#birthday").click
	    	find("select.ui-datepicker-month").select("Jan")
	    	click_link("1")
	    	sleep 1
	    	find("#birthday").value.should eq "01/01/#{curr_date.year}"
	    end
	  end

	  describe "Time Picker" do
	    it "is displayed when time field receives focus and is hidden 
	  				when time field loses focus" do
	    	find("#lunchtime").click
	    	page.should have_selector("#ui-datepicker-div", visible: true)
	    	find("#schedule_name").click
	    	sleep 1
	    	page.should have_no_selector("#ui-datepicker-div", visible: true)
	    end
	    
	    it "fills in  the time field correctly and disappears when 'Done' button clicked" do
	    	find("#lunchtime").click
	    	#find("select[data-unit='hour']").select("13")
	    	#find("select[data-unit='minute']").select("15")
	    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(62, 0) #1 pm
	    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(27, 0) #15 min
	    	find("button.ui-datepicker-close").click
	    	find("#lunchtime").value.should eq "13:15"
	    end
	    describe "Options" do
	      it "displays seconds when specified" do
	      	find("#alarm_setting").click
	      	within("div.ui_tpicker_second_slider", visible: true) do 
	      		page.should have_selector("span.ui-slider-handle")
	      	end
	      end
	    end
	  end

	  describe "Datetime Picker" do
	    it "is displayed when datetime field receives focus and hidden 
	  				when datetime field loses focus" do
	    	find("#apocalypse").click
	    	page.should have_selector("#ui-datepicker-div", visible: true)
	    	find("#schedule_name").click
	    	sleep 1
	    	page.should have_no_selector("#ui-datepicker-div", visible: true)
	    end
	    
	    it "fills in the datetime field correctly and disappears when 'Done' button clicked" do
	    	find("#apocalypse").click
	    	curr_date = Time.now
	    	click_link("1")
	    	click_link("1")
	    	# find("select[data-unit='hour']").select("13")
	    	# find("select[data-unit='minute']").select("14")
	    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(62, 0) #1 pm
	    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(27, 0) #15 min
	    	find("button.ui-datepicker-close").click
	    	find("#apocalypse").value
	    		.should eq "#{'%02i' % curr_date.month}/01/#{curr_date.year} 13:15"
	    end
	  end
  end
  
  describe "Update Existing", :js => true do
  	before(:each) do
  		@curr_date = Time.now
  	  @schedule = FactoryGirl.create(:schedule, birthday: @curr_date.to_date, 
  	  	lunchtime: @curr_date.to_time.strftime("%H:%M"), apocalypse: @curr_date.to_datetime)
  	  visit edit_schedule_path(@schedule)
  	end
    describe "Date Picker" do
    	it "displays current value in format specified in locale file" do
    		find("#birthday").value.should eq I18n.localize(@curr_date.to_date)
    	end
    end
    describe "Time Picker" do
    	it "displays current value in format specified in locale file" do
    		find("#lunchtime").value.should eq I18n.localize(@curr_date.to_time)
    	end
    	

    end
    describe "Datetime Picker" do
    	it "displays current value in format specified in locale file" do
    		find("#apocalypse").value.should eq I18n.localize(@curr_date.to_datetime, format: :datetime)
    	end
    end
  end
end
