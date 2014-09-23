# require 'spec_helper'
# describe FormHelper do
# 	describe ActionView::Helpers::FormBuilder do
# 		before(:each) do
# 			@schedule = FactoryGirl.create(:schedule)
# 			# @object = double(Schedule)
# 			# @builder = ActionView::Helpers::FormBuilder.new(:schedule, @object, self, {})
# 			@template = Object.new
# 			@template.extend ActionView::Helpers::FormHelper
# 			@template.extend ActionView::Helpers::FormOptionsHelper
# 		end
# 		it "defines methods" do
# 			form_builder = ActionView::Helpers::FormBuilder.new(:schedule, @schedule, @template, {})
# 			binding.pry
# 		end  
# 	end
# end