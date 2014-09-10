# HotDateRails #

#### Description ####
There's a ton of time/date/datetime picker gems out, but I couldn't find one that worked for what I needed. This one is a single gem that allows you to add date only, time only and datetime pickers to your forms. This gem also takes into account the way Ruby doesn't parse certain American-friendly dates so it passes along hidden fields with the values expected by rails. When updating the values they are "localized" using the locale file to get them into the format expected by the picker. 

#### Usage ####
- Add `gem 'hot_date_rails'` to Gemfile
- run `bundle install`
- make sure application.js already contains the following
	- //= require jquery
  - //= require jquery_ujs
- In application.js add `//=require hot_date_rails`
- In application.css add ` *=require hot_date_rails`

#### Example Form Helper Calls ####
```RHTML
<!--Using Default values-->
<%= form_for @schedule do |f| %>
<table>
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
</table>
<% end %>
```

```RHTML
<!--Using some Options-->
<%= form_for @schedule do |f| %>
<table>
	<tr>
		<td><%= f.hd_label :alarm_setting %></td>
		<td><%= f.time_picker :alarm_setting, { :hour_grid => "12", :time_format => "HH:mm:ss" }, :w_seconds %></td>
	</tr>
	<tr>
		<td><%= f.hd_label :suppertime %></td>
		<td><%= f.time_picker :suppertime, { :time_format => "h:mm tt" }, :lc_merid %></td>
	</tr>
	<tr>
		<td><%= f.hd_label :beer_oclock %></td>
		<td><%= f.time_picker :beer_oclock, { :time_format => "h:mm TT" }, :uc_merid %></td>
	</tr>
	<tr>
		<td><%= f.hd_label :christmas %></td>
		<td><%= f.date_picker :christmas, { :date_format => "MM d, yy" }, :full_month %></td>
	</tr>
	<tr>
		<td><%= f.hd_label :easter %></td>
		<td><%= f.date_picker :easter, { :date_format => "DD MM d, yy", html: { style: "width: 200px;", data: { microdata: "test" } } }, :full_day_month %></td>
	</tr>
	<!--More Coming Soon!-->
</table>
```


-Not all options are implemented yet
#### Form Helper Options ####
|                  | DatePicker | TimePicker | DatetimePicker |
| --------------   | ---------- | ---------- | -------------- |
| date-format      |     X      |            |       X        |
| change-month     |     X      |            |       ?        |
| change-year      |     X      |            |       ?        |
| time-format*     |            |     X      |       X        |
| alt-time-format* |            |     X      |       X        |
| hour-grid        |            |     X      |       X        |
| minute-grid      |            |     X      |       X        |
| second-grid      |            |     X      |       X        |
| time-only        |            |     ?      |       X        |

\* *time-format & alt-time-format should probably be set to the same value*


##### TODO #####
- see if we can/should add these to hot_date_rails too so user doesn't need to
 - //= require jquery
 - //= require jquery_ujs
