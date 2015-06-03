require 'spec_helper'
describe ActionView::Helpers::FormBuilder do
 	before(:each) do
		@template = Object.new
 		@template.extend ActionView::Helpers::FormHelper
 		@template.extend ActionView::Helpers::FormOptionsHelper
 		@schedule = FactoryGirl.create(:schedule)
 		@object = double(Schedule)
 		@builder = ActionView::Helpers::FormBuilder.new(:schedule, @object, self, {})
 	end
	
	describe "Instance methods" do
	  it "has a method hd_picker" do
	  	@builder.should respond_to(:hd_picker)
	  end
	end
	describe "Deprecated methods" do
	  it "passes an original call to f.date_picker through to f.hd_picker" do
	  	 # subject.stub(:bar)
	  	 
	     # @builder.date_picker(:birthday)
	     # expect(@builder).to have_received(:hd_picker).with(:birthday)
	  end
	end
end