require 'spec_helper'

RSpec.describe "Hot Date Picker Tag", :type => :request do
	describe "standalone form", :js => true do
    before(:each) do
  	  visit filtered_schedules_path
      find("form").click #needed to set focus so events are picked up
  	end
    
  	it "is displayed when date field receives focus and hidden 
  				when start_date field loses focus" do
    	find("#start_date").click
    	page.should have_selector("#ui-datepicker-div", visible: true)
    end

  end
end