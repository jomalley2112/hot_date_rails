require 'spec_helper'

RSpec.describe "Picker Microdata Customization", :type => :request do
	before(:each) do
	  visit '/custom_schedules/new'
	end

	describe "doesn't affect certain existing features" do
		describe "still allows microdata to be passed through", :js => true do
			it "has the data-my-data attribute" do
				expect(find("input#suppertime")['data-my-data']).to match("true")
			end
		end
		describe "allows css classes to be passed through while adding the necessary picker class" do
		  it "has classes 'css_class' and 'my_class'" do
		  	expect(find("input#suppertime")['class']).to match("css_class")
		  	expect(find("input#suppertime")['class']).to match("my_class")
		  end
		end
	end
	

	describe "Date Picker" do
	  pending
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
	  pending
	end

end