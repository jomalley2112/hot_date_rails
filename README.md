# HotDateRails #

#### Usage ####
- Add `gem 'hot_date_rails'` to Gemfile
- run `bundle install`
- In application.js add `//=require hot_date_rails`
- In application.css add ` *=require hot_date_rails`

#### Example Form Helper Calls ####
```RHTML
<%= form_for @schedule do |f| %>
<table>
	<tr>
		<td><%= f.label :name %></td>
		<td><%= f.text_field :name %></td>
	</tr>
	<tr>
		<td><%= f.hd_label :birthday %></td>
		<td><%= f.date_picker :birthday %></td>
	</tr>
	<tr>
		<td><%= f.hd_label :lunchtime %></td>
		<td><%= f.time_picker :lunchtime %></td>
	</tr>
	<tr>
		<td><%= f.hd_label :apocalypse %></td>
		<td><%= f.datetime_picker :apocalypse %></td>
	</tr>
<% end %>
```
- More Coming Soon!

-Not all options implemented yet
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
