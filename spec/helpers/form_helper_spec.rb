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
	    it "sets the id attributes to a 'rails-namespaced' value" do
	    	input = @builder.hd_picker(:birthday)
	    	expect(id_attr(input)).to eq "schedule_birthday"
	    end
	  end
	  context 'when multiple inputs for the same attribute exist' do
	  	let!(:person) { FactoryGirl.create(:person) }
	  	
	  	before do
	  	  2.times { person.schedules << FactoryGirl.create(:schedule) }
	  	end
	  	let!(:person_form_builder) { 
	  		ActionView::Helpers::FormBuilder.new(:person, person, template, {}) 
	  	}
	  	context "when we can manually specify unique ids" do
	  		before do
		  		person_form_builder.fields_for(person.schedules.first) do |schedule|
		  	  	@input1 = schedule.hd_picker(:birthday, {html: {id: "birthday-a"}})
		  	  end
		  	  person_form_builder.fields_for(person.schedules.last) do |schedule|
		  	  	@input2 = schedule.hd_picker(:birthday, {html: {id: "birthday-b"}})
		  	  end
		  	end
	  	  example "the output code for the inputs has unique id attributes" do
	  	  	expect(id_attr(@input1)).not_to eq(id_attr(@input2))
	  	  end
	  	  example "the 'hidden' input has its own unique id attribute" do
	  	  	expect(id_attr(@input1, "hidden")).not_to eq(id_attr(@input2, "hidden"))
	  	  end
	  	end

	  end
	
	end

	private
	def id_attr(input, type="text")
		Nokogiri::HTML.parse(input).xpath("//input[@type='#{type}']").attribute("id").value
	end
	
end