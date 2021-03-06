require 'spec_helper'

RSpec.describe "Date Picker", :type => :request do
  describe "Create New", :js => true do
    before(:each) do
  	  visit new_schedule_path
      find("form").click #needed to set focus so events are picked up
  	end
    
  	it "is displayed when date field receives focus and hidden 
  				when date field loses focus" do
    	find("#schedule_birthday").click
    	page.should have_selector("#ui-datepicker-div", visible: true)
    	find("#schedule_name").click
    	page.should have_no_selector("#ui-datepicker-div", visible: true)
    end
    
    it "fills in the date field correctly and disappears when day is clicked" do
    	curr_date = Time.now
    	find("#schedule_birthday").click
    	find("select.ui-datepicker-month").select("Jan")
    	click_link("1")
    	sleep 1
    	find("#schedule_birthday").value.should eq "01/01/#{curr_date.year}"
    end

    describe "optional formats" do
    	it "fills in the date field with the full month name when day is clicked" do
	    	curr_date = Time.now
	    	find("#schedule_christmas").click
	    	find("select.ui-datepicker-month").select("Dec")
	    	click_link("25")
	    	sleep 1
	    	find("#schedule_christmas").value.should eq "December 25, #{curr_date.year}"
	    end
     	it "fills in the date field with the full day name when day is clicked" do
	    	curr_date = Time.now
	    	find("#schedule_easter").click
	    	find("select.ui-datepicker-month").select("Apr")
	    	click_link("30")
	    	sleep 1
	    	find("#schedule_easter").value.should match(%r(.*day April 30, #{curr_date.year}))
	    end
      
      describe "updated date is properly persisted in the database" do
        it "updates data with the full month name when day is clicked" do
          curr_date = Time.now
          find("#schedule_christmas").click
          find("select.ui-datepicker-month").select("Dec")
          click_link("25")
          sleep 1
          find("input[value='Create Schedule']").click
          find("#schedule_christmas").value.should eq "December 25, #{curr_date.year}"
        end
        it "updates the data with the full day name when day is clicked" do
          curr_date = Time.now
          find("#schedule_easter").click
          find("select.ui-datepicker-month").select("Apr")
          click_link("30")
          sleep 1
          find("input[value='Create Schedule']").click
          find("#schedule_easter").value.should match(%r(.*day April 30, #{curr_date.year}))
        end
      end
    end
	  
	end
  
  
  describe "Update Existing", :js => true do
  	
  	it "displays current value in default format specified in locale file" do
  		@curr_date = Time.now
  	  @schedule = create(:schedule, birthday: @curr_date.to_date)
  	  visit edit_schedule_path(@schedule)
  		find("#schedule_birthday").value.should eq I18n.localize(@curr_date.to_date)
  	end

  	describe "date value is correctly indicated on the datepicker widget" do
  		describe "standard format" do
  			it "selects correct date when displaying 11/11/2013" do
	    		@curr_date = Time.now
		  	  @schedule = create(:schedule, birthday: "#{@curr_date.year}-11-11")
		  	  visit edit_schedule_path(@schedule)
          find("body").click
	      	find("#schedule_birthday").click
	      	find("select.ui-datepicker-month").value.should eq "10" #zero-based value for November
	      	find("select.ui-datepicker-year").value.should eq @curr_date.year.to_s
	      	find("a.ui-state-active").text.should eq "11"
				end
  		end
	  	describe "optional formats" do
	    	it "selects correct date when displaying December 25, 2013" do
	    		@curr_date = Time.now
		  	  @schedule = create(:schedule, christmas: "#{@curr_date.year}-12-25")
		  	  visit edit_schedule_path(@schedule)
          find("body").click
	      	find("#schedule_christmas").click
	      	find("select.ui-datepicker-month").value.should eq "11" #zero-based value for December
	      	find("select.ui-datepicker-year").value.should eq @curr_date.year.to_s
	      	find("a.ui-state-active").text.should eq "25"
				end
        it "selects correct date when displaying .*day Apr 30, 2014" do
          @curr_date = Time.now
          @schedule = create(:schedule, easter: "#{@curr_date.year}-4-30")
          visit edit_schedule_path(@schedule)
          find("body").click
          find("#schedule_easter").click
          find("select.ui-datepicker-month").value.should eq "3" 
          find("select.ui-datepicker-year").value.should eq @curr_date.year.to_s
          find("a.ui-state-active").text.should eq "30"
        end
	    end
    end

  end
end
