require 'spec_helper'

describe "ActionView::Helpers::FormTagHelper" do
	let!(:template) { Object.new }
	let!(:schedule) { FactoryBot.create(:schedule) }
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

		context 'when specifying an id' do
			before do
			  @input1 = template.hd_picker_tag(:birthday, nil, "datepicker", {html: {id: "input1-id"}})
			end
			describe 'sets the id attribute accordingly' do
				example "for the text input" do
					expect(id_attr(@input1)).to eq("input1-id")
				end
			end
			it 'does not set the id attribute to the same thing for both the text and hidden inputs' do
				expect(id_attr(@input1)).not_to eq(id_attr(@input1, "hidden"))
			end
		end
		
	end
end