require 'spec_helper'

RSpec.describe "NoSqlModel", :type => :request, js: true do
 #The way I got this to work with Mongoid is to call the specific form helpers in the view instead of generic hd_picker()
	it "works with date picker" do
		visit new_no_sql_model_path
		find("#birthday").click
    page.should have_selector(".ui-datepicker-week-end")
		page.should_not have_selector(".ui-timepicker-div")
	end
	it "works with time picker" do
		visit new_no_sql_model_path
		find("#lunchtime").click
		page.should have_selector(".ui-timepicker-div")
		page.should_not have_selector(".ui-datepicker-week-end")
	end
	it "works with datetime picker" do
		visit new_no_sql_model_path
		find("#apocalypse").click
		page.should have_selector(".ui-datepicker-week-end")
    page.should have_selector(".ui-timepicker-div")
	end
end