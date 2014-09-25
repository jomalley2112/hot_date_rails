require 'spec_helper'

RSpec.describe "HotDate form field label", :type => :request do
	describe "Accepts same arguments as label_tag method" do
	  it "allows user to over text of label tag" do
	  	visit new_schedule_path
	  	page.should have_content("Time for beer yet?")
	  end
	end
end