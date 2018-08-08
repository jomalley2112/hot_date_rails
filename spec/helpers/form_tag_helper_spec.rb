require 'spec_helper'

describe "ActionView::Helpers::FormTagHelper" do
	let!(:template) { Object.new }
	let!(:schedule) { FactoryGirl.create(:schedule) }
	before do
	  template.extend ActionView::Helpers::FormTagHelper
 		template.extend ActionView::Helpers::FormOptionsHelper
	end
	
	describe 'hd_picker_tag' do
		context 'when adding multiple input tags of the same name' do
			before do
			  @input1 = template.hd_picker_tag(:birthday)
			  @input2 = template.hd_picker_tag(:birthday)
			end
			it "gives the 'text' input its own unique id attribute" do
				expect(id_attr(@input1)).not_to eq(id_attr(@input2))
			end	
			it "gives the 'hidden' input its own unique id attribute" do
				expect(id_attr(@input1, "hidden")).not_to eq(id_attr(@input2, "hidden"))
			end	
		end
		
	end
end