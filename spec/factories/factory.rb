FactoryGirl.define do

  factory :schedule do
    sequence(:name) { |n| "John_#{n}" }
    birthday Time.now
    lunchtime Time.now
    apocalypse Time.now
    epoch Time.now
    christmas Time.now
    alarm_setting Time.now
  end

end