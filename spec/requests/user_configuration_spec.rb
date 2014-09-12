require 'spec_helper'

RSpec.describe "User Configuration", :type => :request do
	describe "Default overrides", :js => true do
	  before(:each) do
		  visit '/custom_schedules/new'
		end
		it "shows Minute grid with intervals of 15" do
			find("input#suppertime").click
			#default is overridden in spec/dummy/config/environment.rb
			page.should have_selector(:xpath, "//table[@class='ui-tpicker-grid-label']//td[text()='15']")
			page.should have_selector(:xpath, "//table[@class='ui-tpicker-grid-label']//td[text()='30']")
			page.should have_selector(:xpath, "//table[@class='ui-tpicker-grid-label']//td[text()='45']")
		end
	end
end