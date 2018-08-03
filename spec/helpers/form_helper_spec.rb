require 'spec_helper'
include ActionView::Context
describe ActionView::Helpers::FormBuilder do
 	let!(:template) { Object.new }
 	let!(:schedule) { FactoryGirl.create(:schedule) }
 	before(:each) do
		template.extend ActionView::Helpers::FormHelper
 		template.extend ActionView::Helpers::FormOptionsHelper
 		@builder = ActionView::Helpers::FormBuilder.new(:schedule, schedule, template, {})
 	end
	
	describe "Instance methods" do
	  it "has a method hd_picker" do
	  	@builder.should respond_to(:hd_picker)
	  end
	  describe '#hd_picker' do
	    it "sets the id attribute to a 'rails-namespaced' value" do
	    	input = @builder.hd_picker(:birthday)
	    	id_value = Nokogiri::HTML.parse(input).xpath("//input").attr("id").value
	    	expect(id_value).to eq "schedule_birthday"
	    end
	  end
	  context 'when multiple inputs for the same attribute exist' do
	  	let!(:person) { FactoryGirl.create(:person) }
	  	let(:input_id) { proc {|input| "person_schedule_#{input.object.id}"} }
	  	before do
	  	  2.times { person.schedules << FactoryGirl.create(:schedule) }
	  	end
	  	let!(:person_form_builder) { 
	  		ActionView::Helpers::FormBuilder.new(:person, person, template, {}) 
	  	}
	  	example "we can manually give them unique ids" do
	  		person_form_builder.fields_for(person.schedules.first) do |s|
	  	  	@input1 = s.hd_picker(:birthday, {html: {id: input_id.call(s)}})
	  	  end
	  	  person_form_builder.fields_for(person.schedules.last) do |s|
	  	  	@input2 = s.hd_picker(:birthday, {html: {id: input_id.call(s)}})
	  	  end
	  	  expect(id_attr(@input1)).not_to eq(id_attr(@input2))
	  	end
	  end
	
	end

	private
	def id_attr(input)
		Nokogiri::HTML.parse(input).xpath("//input[@type='text']").attribute("id").value
	end
	
end