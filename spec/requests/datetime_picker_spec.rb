require 'spec_helper'

RSpec.describe "Datetime Picker", :type => :request do
  describe "Create New", :js => true do
    before(:each) do
  	  visit new_schedule_path
      find("form").click #needed to set focus so events are picked up
  	end
  
	  it "is displayed when datetime field receives focus and hidden 
  				when datetime field loses focus" do
    	find("#apocalypse").click
    	page.should have_selector("#ui-datepicker-div", visible: true)
    	find("#schedule_name").click
    	sleep 1
    	page.should have_no_selector("#ui-datepicker-div", visible: true)
    end
    
    it "fills in the datetime field correctly and disappears when 'Done' button clicked", slider: true do
    	find("#apocalypse").click
    	curr_date = Time.now
    	click_link("1")
    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(76, 0) #1 pm
    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(35, 0) #15 min
    	find("button.ui-datepicker-close").click
    	find("#apocalypse").value
    		.should eq "#{'%02i' % curr_date.month}/01/#{curr_date.year} 13:15"
    end

    describe "Alternate Datetime formats" do
      it "shows datetime with seconds", slider: true do
        find("#epoch").click
        curr_date = Time.now
        click_link("1")
        find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(76, 0) #1 pm
        find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(35, 0) #15 min
        find("div.ui_tpicker_second_slider").find("span.ui-slider-handle").drag_by(35, 0) #15 sec
        find("button.ui-datepicker-close").click
        find("#epoch").value
          .should eq "#{curr_date.month}/1/#{curr_date.year} 13:15:15"
        click_button("Create Schedule")
        find("#epoch").value
          .should eq "#{curr_date.month}/1/#{curr_date.year} 13:15:15"
      end
    end

	end
  
  describe "Update Existing", :js => true do
  	before(:each) do
  		@curr_date = Time.now
  	  @schedule = FactoryGirl.create(:schedule, apocalypse: @curr_date.to_datetime)
  	  visit edit_schedule_path(@schedule)
  	end

  	it "displays current value in format specified in locale file" do
  		find("#apocalypse").value.should eq I18n.localize(@curr_date.to_datetime, format: :datetime)
  	end

  end

  describe "specify jQuery widget class name", :js => true do
    before do 
      visit '/custom_schedules/new'
      find("body").click
    end
    describe "just date" do
      it "shows just the date and only the date" do
        find("#date_in_time").click
        page.should have_selector("table.ui-datepicker-calendar")
        page.should_not have_selector("div.ui-timepicker-div")
      end
      it "shows the date that we chose in the correct localized format" do
        @curr_date = Time.now
        @schedule = FactoryGirl.create(:schedule, date_in_time: @curr_date.to_date)
        visit "/custom_schedules\/#{@schedule.id}\/edit"
        find("#date_in_time").value.should eq I18n.localize(@curr_date.to_date)
      end
    end

    describe "just time" do
      it "shows just the time and only the time" do
        find("#time_of_date").click
        page.should have_selector("div.ui-timepicker-div")
        page.should_not have_selector("table.ui-datepicker-calendar")
      end
      it "shows the date that we chose in the correct localized format" do
        @curr_date = Time.now
        @schedule = FactoryGirl.create(:schedule, time_of_date: @curr_date)
        visit "/custom_schedules\/#{@schedule.id}\/edit"
        find("#time_of_date").value.should eq @curr_date.strftime("%H:%M")
      end
    end
    
  end
end
