# HotDateRails #

#### Description ####
There's a ton of time/date/datetime picker gems out, but I couldn't find one that worked for what I needed. This one is a single gem that allows you to add date only, time only and datetime pickers to your forms. This gem also takes into account the way Ruby doesn't parse certain American-friendly dates so it passes along hidden fields with the values expected by rails. When updating the values they are "localized" using the locale file to get them into the format expected by the picker. 

#### Setup ####
- Add `gem 'hot_date_rails', :github => 'jomalley2112/hot_date_rails'` to Gemfile
- run `bundle install`
- make sure application.js already contains the following
  - `//= require jquery`
  - `//= require jquery_ujs`
- In application.js add `//=require hot_date_rails`
- In application.css add ` *=require hot_date_rails`

#### Form Helper Usage ####
```ruby
form_object.date_picker(name, options={}, locale_format=nil)
form_object.time_picker(name, options={}, locale_format=nil)
form_object.datetime_picker(name, options={}, locale_format=nil)
```
- *name* is a symbol representing the form field
- *options* see the [Form Helper Options](#fho) section below
- *locale_format* is the name of a strftime format specified under the corresponding branch in the locale file. Use this when specifying :date_format and/or :time_format. This is necessary to synchronize the format strings used for the date/time pickers with Ruby's [strftime format directives](http://apidock.com/ruby/DateTime/strftime).
	- A base set of locale_formats are included for english and custom formats can be added.

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
		<td><%= f.time_picker :alarm_setting, { :time_format => "HH:mm:ss", :hd_opts => { :hour_grid => "12" } }, :w_seconds %></td>
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
		<td><%= f.date_picker :easter, { :date_format => "DD MM d, yy", html: { style: "width: 200px;", data: { microdata: "a value" } } }, :full_day_month %></td>
	</tr>
</table>
```

#### <a name="fho"></a>Form Helper Options ####
- :date_format - datepicker [format string](http://api.jqueryui.com/datepicker/)
	- default: "mm/dd/yy"
- :time_format - timepicker [format string](http://trentrichardson.com/examples/timepicker/)
	- default: "HH:mm"
- :html - attributes to be added to the input field
- :hd_opts - options to be applied to the picker object

##### Common :hd_opts
|                  | DatePicker | TimePicker | DatetimePicker |
| --------------   | ---------- | ---------- | -------------- |
| change_month     |     X      |            |       ?        |
| change_year      |     X      |            |       ?        |
| alt_time_format* |            |     X      |       X        |
| hour_grid        |            |     X      |       X        |
| minute_grid      |            |     X      |       X        |
| second_grid      |            |     X      |       X        |

\* *alt_time_format should be overridden when you need more precision than minutes for a datetime picker (e.g. "HH:mm:ss")*

#### Overriding Global Defaults ####
Add a block similar to the following in your `config/environment.rb` file somewhere after the `Rails.application.initialize!` call:
```ruby
HotDateRails.config do |config|
  config.hour_grid = "12"
  config.minute_grid = "15"
  config.second_grid = "30"
end
```

##### TODO #####
- see if we can/should add these to hot_date_rails too so user doesn't need to
 - //= require jquery
 - //= require jquery_ujs
