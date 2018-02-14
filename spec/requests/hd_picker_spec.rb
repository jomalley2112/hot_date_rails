require 'spec_helper'

RSpec.describe "Hot Date Picker helper", :type => :request do
	let!(:start_date) { Date.today - 1.week }
	context 'when the a start date is selected and the form is submitted', js: true do
    before do
      visit last_updated_filter_path
      find("form").click
      fill_in "start_date", with: I18n.l(start_date)
      click_button "Filter"
      sleep 2  
    end
    context 'when the start date is left alone and the form is submitted again' do
      before { click_button "Filter" }
      # it 'submits the same start date' do
      #   expect(find("#start_date").value).to eq I18n.l(start_date)
      # end   
    end
  end
	
end