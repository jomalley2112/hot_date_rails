require 'spec_helper'

RSpec.describe "User Configuration", :type => :request do
	describe "Default overrides", :js => true do
	  before(:each) do
		  visit '/custom_schedules/new'
		end
		it "shows Minute grid with intervals of 15" do
			find("input#lunchtime").click
			#default is overridden in spec/dummy/config/environment.rb
			page.should have_selector(:xpath, "//table[@class='ui-tpicker-grid-label']//td[text()='15']")
			page.should have_selector(:xpath, "//table[@class='ui-tpicker-grid-label']//td[text()='30']")
			page.should have_selector(:xpath, "//table[@class='ui-tpicker-grid-label']//td[text()='45']")
		end
		it "overrides the default value we already overrode when explicitly passed to tag" do
			find("input#suppertime").click
			page.should have_selector(:xpath, "//table[@class='ui-tpicker-grid-label']//td[text()='20']")
			page.should have_selector(:xpath, "//table[@class='ui-tpicker-grid-label']//td[text()='40']")
		end
		it "doesn't show any grid numbers when the option is passed an empty string" do
			find("input#alarm_setting").click
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_hour']//table[@class='ui-tpicker-grid-label']//td[text()='16']")
			page.should have_selector(:xpath, "//dd[@class='ui_tpicker_minute']//table[@class='ui-tpicker-grid-label']//td[text()='30']")
			page.should_not have_selector(:xpath, "//dd[@class='ui_tpicker_second']//table[@class='ui-tpicker-grid-label']//td")
		end
	end

end