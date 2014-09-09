require 'spec_helper'

RSpec.describe "Datetime Picker", :type => :request do
  describe "Create New", :js => true do
    before(:each) do
  	  visit new_schedule_path
  	end
  
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
end
