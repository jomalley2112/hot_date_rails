require 'spec_helper'

RSpec.describe "ScheduleSpecs", :type => :request do
  describe "Create New" do
    describe "Date Picker", :js => true do
	    it "is displayed when date field receives focus" do
	    	visit new_schedule_path
	    	binding.pry
	    	find("#birthday_vis").click
	    	page.should have_element("div.ui-datepicker-div")
	    	
	    end
	    it "disappears when date field loses focus" do
	    end
	    it "fills in  the date field and disappears when done button clicked" do
	    end
	  end

	  describe "Time Picker" do
	    it "is displayed when time field receives focus" do
	    end
	    it "disappears when time field loses focus" do
	    end
	    it "fills in  the time field and disappears when done button clicked" do
	    end
	  end

	  describe "Datetime Picker" do
	    it "is displayed when datetime field receives focus" do
	    end
	    it "disappears when datetime field loses focus" do
	    end
	    it "fills in  the datetime field and disappears when done button clicked" do
	    end
	  end
  end
  
  describe "Update Existing" do
    
  end
end
