# Unfinished Project #

#### Usage ####
- Add `gem 'hot_date_rails'` to Gemfile
- run `bundle install`
- In application.js add `//=require hot_date_rails`
- In application.css add ` *=require hot_date_rails`

#### Example Form Helper Calls ####
- Coming Soon!

#### Form Helper Options ####
|                | DatePicker | TimePicker | DatetimePicker |
| -------------- | ---------- | ---------- | -------------- |
| dateFormat     |     X      |            |       X        |
| changeMonth    |     X      |            |       ?        |
| changeYear     |     X      |            |       ?        |
| timeFormat*    |            |     X      |       X        |
| altTimeFormat* |            |     X      |       X        |
| hourGrid       |            |     X      |       X        |
| minuteGrid     |            |     X      |       X        |
| secondGrid     |            |     X      |       X        |
| timeOnly       |            |     ?      |       X        |

\* *timeFormat & altTimeFormat should probably be set to the same value*


##### TODO #####
- see if we can/should add these to hot_date_rails too
 - //= require jquery
 - //= require jquery_ujs
