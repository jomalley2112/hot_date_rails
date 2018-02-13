require 'spec_helper'
describe ActionView::Helpers::FormBuilder do
 	before(:each) do
		@template = Object.new
 		@template.extend ActionView::Helpers::FormHelper
 		@template.extend ActionView::Helpers::FormOptionsHelper
 		@schedule = FactoryGirl.create(:schedule)
 		@object = double(Schedule)
 		@builder = ActionView::Helpers::FormBuilder.new(:schedule, @schedule, @template, {})
 	end
	
	describe "Instance methods" do
	  it "has a method hd_picker" do
	  	@builder.should respond_to(:hd_picker)
	  end
	  describe '#hd_picker' do
	    it 'sets the value of the hidden field based on value passed in' do
	    	input = @builder.hd_picker(:birthday, { html: { value: "1/1/2001" } })
	    	input_val = Nokogiri::HTML.parse(input).xpath("//input[@id='birthday_hdn']").first[:value]
	    	expect(input_val).to eq "2001-01-01"
	    end
	  end
	end
	
end