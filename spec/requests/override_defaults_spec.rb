require 'spec_helper'

#Usage: rspec spec --tag @defaults --order default
#To run all other specs: rspec spec --tag ~@defaults

RSpec.describe "Override Defaults", :type => :request, :js => true, defaults: true do
	describe "time grid intervals" do
		before(:each) do
	  	visit '/custom_schedules/new'
	  	find("form").click
		end
	  it "shows Minute grid with intervals of 15" do
			find("input#schedule_lunchtime").click
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_minute']//table[@class='ui-tpicker-grid-label']//td[text()='15']")
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_minute']//table[@class='ui-tpicker-grid-label']//td[text()='30']")
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_minute']//table[@class='ui-tpicker-grid-label']//td[text()='45']")
		end
		it "overrides the default value we already overrode when explicitly passed to tag" do
			find("input#schedule_suppertime").click
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_minute']//table[@class='ui-tpicker-grid-label']//td[text()='20']")
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_minute']//table[@class='ui-tpicker-grid-label']//td[text()='40']")
		end
		it "doesn't show any grid numbers when the option is passed an empty string" do
			find("input#schedule_alarm_setting").click
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_hour']//table[@class='ui-tpicker-grid-label']//td[text()='16']")
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_minute']//table[@class='ui-tpicker-grid-label']//td[text()='30']")
			page.should_not have_selector(:xpath, "//dd[@class='ui_tpicker_second']//table[@class='ui-tpicker-grid-label']//td")
		end
	end

	describe "date and time format factory defaults" do
	  describe "date format" do
		
			describe "HotDateRails default date" do
				before(:each) do
			  	visit new_schedule_path
			  	find("body").click
				end
				it "fills in the date field with date formatted like 01/01/2001" do
		    	curr_date = Time.now
		    	find("#schedule_birthday").click
		    	find("select.ui-datepicker-month").select("Jan")
		    	click_link("1")
		    	sleep 1
		    	find("#schedule_birthday").value.should eq "01/01/#{curr_date.year}"
		    end
			end
			
		end
		describe "time Format", slider: true do
			describe "HotDateRails time default" do
				before(:each) do
			  	visit new_schedule_path
			  	find("body").click
				end
				it "fills in the time field with time formatted like 23:59 " do
		    	find("#schedule_lunchtime").click
		    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(76, 0)
		    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(35, 0)
		    	find("button.ui-datepicker-close").click
		    	find("#schedule_lunchtime").value.should eq "13:15"
		    end
			end
		end
		describe "datetime Format", slider: true do
			describe "HotDateRails datetime default" do
				before(:each) do
			  	visit new_schedule_path
			  	find("body").click
				end
				it "fills in the datetime field with datetime formatted like 01/01/2001 23:59 " do
					find("#schedule_apocalypse").click
		    	first("a.ui-state-default", text: "1").click
		    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(76, 0)
		    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(35, 0)
		    	find("button.ui-datepicker-close").click
		    	sleep 1
		    	find("#schedule_apocalypse").value.should match(/\d\d\/\d\d\/\d{4} \d\d:\d\d/)
		    end
			end
			
		end
	end

	describe "override date and time format factory defaults" do
		describe "date format" do
			describe "overridden default time" do
				before(:each) do
			  	#defaults are usually overridden in spec/dummy/config/environment.rb
			  	mock_config_setting :date_format, "MM d, yy"
			  	visit '/custom_schedules/new'
			  	find("body").click
				end
				it "fills in the date field with date formatted like 'January 1, 2010' " do
					find("#schedule_christmas").click
					find("select.ui-datepicker-month").select("Jan")
		    	click_link("1")
		    	sleep 1
		    	find("#schedule_christmas").value.should match(/\w*\s\d{1,2},\s\d{4}/)
				end
			end
		end
		

		describe "time Format", slider: true do
			describe "overridden default time" do
				before(:each) do
			  	mock_config_setting :time_format, "h:mm tt"
			  	visit '/custom_schedules/new'
			  	find("body").click
				end
				it "fills in the time field with time formatted like '9:35 am' " do
					find("#schedule_beer_oclock").click
		    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(76, 0)
		    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(35, 0)
		    	find("button.ui-datepicker-close").click
		    	find("#schedule_beer_oclock").value.should eq "1:15 pm"
				end
			end
		end

		describe "datetime Format", slider: true do
			describe "overridden default datetime" do
				before(:each) do
			  	mock_config_setting :date_format, "MM d, yy"
			  	mock_config_setting :time_format, "h:mm tt"
			  	visit '/custom_schedules/new'
			  	find("body").click
				end
				it "fills in the datetime field with datetime formatted like January 1, 2001 1:59 pm " do
					find("#schedule_epoch").click
					first("a.ui-state-default", text: "1").click
		    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(76, 0)
		    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(35, 0)
		    	find("button.ui-datepicker-close").click
		    	sleep 1
		    	find("#schedule_epoch").value.should match(/\w*\s\d{1,2},\s\d{4} 1:15 pm/)
		    end
			end
		end
	end

end



