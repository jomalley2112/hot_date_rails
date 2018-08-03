require 'spec_helper'

RSpec.describe "Nested Attribute", :type => :request do
	describe "datetime picker" do
		context 'when we have a schedule that belongs to a person' do
			let!(:person) { FactoryGirl.create(:person) }
			let!(:schedule) { FactoryGirl.create(:schedule, person: person) }
			it "generates the correct input fields to update the schedule" do
		  	visit edit_person_path(person)
		  	expect(page).to have_selector("input[name='person[schedules_attributes][0][apocalypse]']")
		  end
		end
	  
	end
end