require 'spec_helper'

RSpec.describe "Picker Microdata Customization", :type => :request do
	before(:each) do
	  visit '/custom_schedules/new'
	  find("form").click #needed to set focus so events are picked up
	end

	describe "doesn't affect certain existing features" do
		describe "still allows microdata to be passed through", :js => true do
			it "has the data-my-data attribute" do
				expect(find("#schedule_suppertime")['data-my-data']).to match("true")
			end
		end
		describe "allows css classes to be passed through while adding the necessary picker class" do
		  it "has classes 'css_class' and 'my_class'" do
		  	expect(find("#schedule_suppertime")['class']).to match("css_class")
		  	expect(find("#schedule_suppertime")['class']).to match("my_class")
		  end
		end
	end
	

	describe "Date Picker", :js => true do
	  before(:each) do
		  find("#schedule_birthday").click
		end
		it "allows us to display the panel containing the Today and Done buttons" do
			page.should have_selector("button.ui-datepicker-current", visible: true)
			page.should have_selector("button.ui-datepicker-close", visible: true)
		end
	end

	describe "Time Picker", :js => true do
		before(:each) do
		  find("#schedule_lunchtime").click
		end
	  describe "add or change text" do
	  	it "allows us to specify the text of the 'Now' button" do
	  		find("button.ui-datepicker-current").text.should eq "Current"
	  	end
	  	it "allows us to set the text on the Done button" do
	  		find("button.ui-datepicker-close").text.should eq "Set"
	  	end
	  	it "allows us to add a suffix after the time displayed" do
	  		find(".ui_tpicker_time_input").value.should match(/.*\so\'clock/)
	  	end
	  end
	end

	describe "Datetime Picker", :js => true do
	  before(:each) do
		  find("#schedule_apocalypse").click
		end
		it "allows us to add a separator between the date and time in the input value" do
			find("a", text: "17").click
			find("#schedule_apocalypse").value.should match(/\d\d\/\d\d\/\d{4} @ \d\d:\d\d/)
		end
	end

end