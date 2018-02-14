require 'spec_helper'

RSpec.describe "Hot Date Picker Tag", :type => :request do
  let!(:start_date) { Date.today - 1.week }

	describe "standalone form", :js => true do
    before(:each) do
  	  visit filtered_schedules_path
      find("form").click #needed to set focus so events are picked up
  	end
    
  	it "is displayed when date field receives focus and hidden 
  				when start_date field loses focus" do
    	find("#start_date").click
    	page.should have_selector("#ui-datepicker-div", visible: true)
    end

    it 'sets the value to the I18n localized format after the form is submitted' do
      fill_in "start_date", with: I18n.l(start_date)
      click_button "Filter"
      sleep 2
      find("#start_date").value.should eq I18n.l(start_date)
    end

  end

  context 'when the a start date is selected and the form is submitted', js: true do
    before do
      visit filtered_schedules_path
      find("form").click
      fill_in "start_date", with: I18n.l(start_date)
      click_button "Filter"
      sleep 2  
    end
    context 'when the start date is left alone and the form is submitted again' do
      before { click_button "Filter" }
      it 'submits the same start date' do
        expect(find("#start_date").value).to eq I18n.l(start_date)
      end   
    end
  end

end