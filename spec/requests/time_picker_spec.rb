require 'spec_helper'

RSpec.describe "Time Picker", :type => :request do
  describe "Create New", :js => true do
    before(:each) do
  	  visit new_schedule_path
  	  find("form").click #needed to set focus so events are picked up
  	end
   	describe "Standard format" do
      it "is displayed when time field receives focus and is hidden 
  				when time field loses focus" do
  			sleep 1
	    	page.execute_script("$('#lunchtime').focus()")
	    	find("#lunchtime").click
	    	sleep 1
	    	# binding.pry
	    	page.should have_selector("#ui-datepicker-div", visible: true)
	    	# find("#schedule_name").click
	    	page.execute_script("$('#lunchtime').blur()")
	    	sleep 1
	    	page.should have_no_selector("#ui-datepicker-div", visible: true)
	    end
	    
	    it "fills in  the time field correctly and disappears when 'Done' button clicked" do
	    	find("#lunchtime").click
	    	find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(76, 0) #1 pm
	    	find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(35, 0) #15 min
	    	find("button.ui-datepicker-close").click
	    	find("#lunchtime").value.should eq "13:15"
	    end
    end
    

    describe "Optional formats" do
      it "displays seconds when specified" do
      	find("#alarm_setting").click
      	within("div.ui_tpicker_second_slider", visible: true) do 
      		page.should have_selector("span.ui-slider-handle") #seconds slider exists
      	end
      end
      
      it "displays like '12:00 am' when specified" do
      	find("#suppertime").click
      	find(".ui_tpicker_time_input").value.should match('12:00 am')
      end

      describe "updated time is properly persisted in the database" do
      	it "updates data properly when lowercase meridian is specified" do
      		find("#suppertime").click
      		find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(76, 0) #1 pm
	    		find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(35, 0) #15 min
	    		find("button.ui-datepicker-close").click
	    		click_button("Create Schedule")
	    		sleep 1
	    		find("input#suppertime").value.should match('1:15 pm')	
      	end
      	it "updates data prpperly when uppercase meridian is specified" do
      		find("#beer_oclock").click
      		# binding.pry
      		find("div.ui_tpicker_hour_slider").find("span.ui-slider-handle").drag_by(76, 0) #1 pm
	    		find("div.ui_tpicker_minute_slider").find("span.ui-slider-handle").drag_by(35, 0) #15 min
	    		find("button.ui-datepicker-close").click
	    		click_button("Create Schedule")
	    		sleep 1
	    		find("input#beer_oclock").value.should match('1:15 PM')	
      	end
      end
    end
	  
  end
  
  describe "Update Existing", :js => true do
  	before(:each) do
  		@curr_date = Time.now
  	  @schedule = FactoryGirl.create(:schedule, lunchtime: @curr_date.to_time.strftime("%H:%M"),
  	  	alarm_setting: @curr_date.to_time.strftime("%H:%M:%S"), 
  	  	suppertime: @curr_date.to_time.strftime("%H:%M"), beer_oclock: @curr_date.to_time.strftime("%H:%M"))
  	  visit edit_schedule_path(@schedule)
  	end
    
  	describe "displays current value in format specified in locale file", :js => false do
  		it "shows default time format" do
  			find("#lunchtime").value.should eq I18n.localize(@curr_date.to_time)
  		end
  		it "shows time with seconds when custom locale_format specified" do
  			find("#alarm_setting").value.should eq I18n.localize(@curr_date.to_time, format: :w_seconds)
  		end
  		it "shows time with 12-hour clock and lower case meridian" do
  			find("#suppertime").value.should eq I18n.localize(@curr_date.to_time, format: :lc_merid).strip
  		end
  		it "shows time with 12-hour clock and upper case meridian" do
  			find("#beer_oclock").value.should eq I18n.localize(@curr_date.to_time, format: :uc_merid).strip
  		end
  	end
		describe "time value is correctly indicated on the timepicker widget" do
		  it "displays default time format" do
		  	find("#lunchtime").click
		  	find("input#lunchtime").value.should match(I18n.localize(@curr_date.to_time))
		  end
		  it "displays time with seconds format" do
		  	find("#alarm_setting").click
		  	find("input#alarm_setting").value.should match(I18n.localize(@curr_date.to_time, format: :w_seconds))
		  end
		  describe "12-hour clock and lower case meridian format" do
		  	it "displays single-digit hour" do
		  		date_obj = DateTime.strptime("1:45 am", "%H:%M %P")
		  		@schedule = FactoryGirl.create(:schedule, suppertime: date_obj)
		  		visit edit_schedule_path(@schedule)
		  		find("#suppertime").click
		  		find("input#suppertime").value.should match(I18n.localize(date_obj, format: :lc_merid))
		  	end
		  	it "displays double-digit hour" do
		  		date_obj = DateTime.strptime("11:47 pm", "%H:%M %P")
		  		@schedule = FactoryGirl.create(:schedule, suppertime: date_obj)
		  		visit edit_schedule_path(@schedule)
		  		find("#suppertime").click
		  		find("input#suppertime").value.should match(I18n.localize(date_obj, format: :lc_merid))
		  	end
		  end

		  describe "12-hour clock and upper case meridian format" do
		  	it "displays single-digit hour" do
		  		date_obj = DateTime.strptime("1:45 am", "%H:%M %p")
		  		@schedule = FactoryGirl.create(:schedule, beer_oclock: date_obj)
		  		visit edit_schedule_path(@schedule)
		  		find("#beer_oclock").click
		  		find("input#beer_oclock").value.should match(I18n.localize(date_obj, format: :uc_merid))
		  	end
		  	it "displays double-digit hour" do
		  		date_obj = DateTime.strptime("11:47 pm", "%H:%M %p")
		  		@schedule = FactoryGirl.create(:schedule, beer_oclock: date_obj)
		  		visit edit_schedule_path(@schedule)
		  		find("#beer_oclock").click
		  		find("input#beer_oclock").value.should match(I18n.localize(date_obj, format: :uc_merid))
		  	end
		  end

		end
		
  end
end
