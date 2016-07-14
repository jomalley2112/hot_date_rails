FactoryGirl.define do

	factory :person do
	  sequence(:name) { |n| "John Doe ##{n}" }
	end

  factory :schedule do
    sequence(:name) { |n| "Schedule ##{n}" }
    birthday Time.now
    lunchtime Time.now
    apocalypse Time.now
    epoch Time.now
    christmas Time.now
    alarm_setting Time.now
  end

end