require 'spec_helper'

#Usage: rspec spec --tag @defaults --order default
#To run all other specs: rspec spec --tag ~@defaults

RSpec.describe "Override Defaults", :type => :request, :js => true, defaults: true do
	describe "time grid intervals" do
		before(:each) do
	  	visit '/custom_schedules/new'
		end
	  it "shows Minute grid with intervals of 15" do
			find("input#lunchtime").click
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_minute']//table[@class='ui-tpicker-grid-label']//td[text()='15']")
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_minute']//table[@class='ui-tpicker-grid-label']//td[text()='30']")
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_minute']//table[@class='ui-tpicker-grid-label']//td[text()='45']")
		end
		it "overrides the default value we already overrode when explicitly passed to tag" do
			find("input#suppertime").click
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_minute']//table[@class='ui-tpicker-grid-label']//td[text()='20']")
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_minute']//table[@class='ui-tpicker-grid-label']//td[text()='40']")
		end
		it "doesn't show any grid numbers when the option is passed an empty string" do
			find("input#alarm_setting").click
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
				end
				it "fills in the date field with date formatted like 01/01/2001" do
		    	curr_date = Time.now
		    	find("#birthday").click
		    	find("select.ui-datepicker-month").select("Jan")
		    	click_link("1")
		    	sleep 1
		    	find("#birthday").value.should eq "01/01/#{curr_date.year}"
		    end
			end
			
		end
		describe "time Format" do
			describe "HotDateRails time default" do
				before(:each) do
			  	visit new_schedule_path
				end
				it "fills in the time field with time formatted like 23:59 " do
		    	find("#lunchtime").click
		    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(62, 0)
		    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(27, 0)
		    	find("button.ui-datepicker-close").click
		    	find("#lunchtime").value.should eq "13:15"
		    end
			end
		end
		describe "datetime Format" do
			describe "HotDateRails datetime default" do
				before(:each) do
			  	visit new_schedule_path
				end
				it "fills in the datetime field with datetime formatted like 01/01/2001 23:59 " do
					find("#apocalypse").click
		    	click_link("1")
		    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(62, 0)
		    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(27, 0)
		    	find("button.ui-datepicker-close").click
		    	sleep 1
		    	find("#apocalypse").value.should match(/\d\d\/\d\d\/\d{4} \d\d:\d\d/)
		    end
			end
			
		end
	end

	describe "override date and time format factory defaults" do
		describe "date format" do
			describe "overridden default time" do
				before(:each) do
			  	HotDateRails.config do |c|
			  		c.date_format = "MM d, yy"
			  	end
			  	#defaults are usually overridden in spec/dummy/config/environment.rb
			  	visit '/custom_schedules/new'
				end
				it "fills in the date field with date formatted like 'January 1, 2010' " do
					find("#christmas").click
					find("select.ui-datepicker-month").select("Jan")
		    	click_link("1")
		    	sleep 1
		    	find("#christmas").value.should match(/\w*\s\d{1,2},\s\d{4}/)
				end
			end
		end
		

		describe "time Format" do
			describe "overridden default time" do
				before(:each) do
			  	HotDateRails.config do |c|
			  		c.time_format = "h:mm tt"
			  	end
			  	visit '/custom_schedules/new'
				end
				it "fills in the time field with time formatted like '9:35 am' " do
					find("#beer_oclock").click
		    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(62, 0)
		    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(27, 0)
		    	find("button.ui-datepicker-close").click
		    	find("#beer_oclock").value.should eq "1:15 pm"
				end
			end
		end

		describe "datetime Format" do
			describe "overridden default datetime" do
				before(:each) do
			  	HotDateRails.config do |c|
			  		c.date_format = "MM d, yy"
			  		c.time_format = "h:mm tt"
			  	end
			  	visit '/custom_schedules/new'
				end
				it "fills in the datetime field with datetime formatted like January 1, 2001 1:59 pm " do
					find("#epoch").click
		    	click_link("1")
		    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(62, 0)
		    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(27, 0)
		    	find("button.ui-datepicker-close").click
		    	sleep 1
		    	find("#epoch").value.should match(/\w*\s\d{1,2},\s\d{4} 1:15 pm/)
		    end
			end
		end
	end

end



