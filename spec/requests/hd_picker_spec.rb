require 'spec_helper'

RSpec.describe "Hot Date Picker helper", :type => :request, js: true do
	before(:each) do
	  visit filtered_schedules_path #TODO: Form needs to use hd_picker instead of hd_picker_tag
    find("form").click #needed to set focus so events are picked up
	end
	context 'when the a start date is selected and the form is submitted' do
		let(:start_date) { Date.today - 1.week }
		before do
			fill_in "start_date", with: I18n.l(start_date)
	    click_button "Filter"
	    sleep 2  
		end
		context 'when the start date is left alone and the form is submitted again' do
			before { click_button "Filter" }
			it 'submits the same start date' do
				pending
				expect(find("#start_date").value).to eq I18n.l(start_date)
			end  	
		end
	end
	
end