require 'spec_helper'

RSpec.describe "NoSqlModel", :type => :request, js: false do

	it "works with date picker" do
		visit new_no_sql_model_path
		find("#birthday").click
    page.should have_selector("#ui-datepicker-div")
	end
	it "works with time picker" do
		visit new_no_sql_model_path
		find("#lunchtime").click
		page.should have_selector("#ui-timepicker-div")
	end
	it "works with datetime picker" do
		visit new_no_sql_model_path
		find("#apocalypse").click
		# binding.pry
    page.should have_selector("#ui-datetimepicker-div")
	end
end