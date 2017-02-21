# HotDateRails #
[![Gem Version](https://badge.fury.io/rb/hot_date_rails.svg)](http://badge.fury.io/rb/hot_date_rails)

#### Description ####
There's a ton of time/date/datetime picker gems out, but I couldn't find one that worked for what I needed. This one is a single gem that allows you to add date, time and datetime pickers to your forms. This gem also takes into account the way Ruby doesn't parse certain American-friendly dates so it passes along hidden fields with the values expected by rails. When updating the values they are "localized" using the locale file to get them into the format expected by the picker. 

#### Setup ####
- Add `gem 'hot_date_rails'` to Gemfile
- run `bundle install`
- make sure application.js contains the following (and that the assets are available to be referenced)
  - `//= require jquery`
  - `//= require jquery-ui`
  - `//= require jquery_ujs`
- In application.js add `//= require hot_date_rails`
- In application.css add ` *= require hot_date_rails`

#### Form Helper Usage ####
```ruby
form_object.hd_label(name, content_or_options=nil, options=nil, &block)
#takes the same arguments as the Rails label_tag method

form_object.hd_picker(name, options={}, locale_format=nil, cls=nil)
```
- *name* - a symbol representing the form field
- *options* - see the [Form Helper Options](#fho) section below
- *locale_format* - the name of a strftime format specified under the corresponding branch in the locale file. Use this when specifying :date_format and/or :time_format. This is necessary to synchronize the format strings used for the date/time pickers with Ruby's [strftime format directives](http://apidock.com/ruby/DateTime/strftime).
	- A [base set](#locales) of locale_formats are included for english and custom formats can be added.
- *cls* - the css class name for the picker object created. This is used solely for the purpose of attaching the correct type of picker to the field. (To specify your own css classes just for formatting you can add them to the options hash.) Valid values are "date", "time" and "datetime". When not specified hd_picker gets this from the type of the column specified.\* \*\*

\* *The only good reason for setting this parameter is if you have a datetime field and you want the field to just show the date or just show the time*

\*\* *If you do specify the cls parameter keep in mind that you will probably need to add another format under the correct branch in the locale file and specify that format in the locale_file parameter*

#### Example Form Helper Calls ####
```RHTML
<!--Using just default values-->
<%= form_for @schedule do |f| %>
<table>
	<tr>
		<td><%= f.hd_label :birthday %></td>
		<td><%= f.hd_picker :birthday %></td><!-- date -->
	</tr>
	<tr>
		<td><%= f.hd_label :lunchtime %></td>
		<td><%= f.hd_picker :lunchtime %></td><!-- time -->
	</tr>
	<tr>
		<td><%= f.hd_label :apocalypse %></td>
		<td><%= f.hd_picker :apocalypse %></td><!-- datetime -->
	</tr>
</table>
<% end %>
```

#### Example Form Helper Calls when Not using ActiveRecord ####
```RHTML
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
		<td><%= f.hd_picker :alarm_setting, { :time_format => "HH:mm:ss", :hd_opts => { :hour_grid => "12" } }, :w_seconds %></td>
	</tr>
	<tr>
		<td><%= f.hd_label :suppertime %></td>
		<td><%= f.hd_picker :suppertime, { :time_format => "h:mm tt" }, :lc_merid %></td>
	</tr>
	<tr>
		<td><%= f.hd_label :beer_oclock, "Time for beer: " %></td>
		<td><%= f.hd_picker :beer_oclock, { :time_format => "h:mm TT" }, :uc_merid %></td>
	</tr>
	<tr>
		<td><%= f.hd_label :christmas %></td>
		<td><%= f.hd_picker :christmas, { :date_format => "MM d, yy" }, :full_month %></td>
	</tr>
	<tr>
		<td><%= f.hd_label :easter %></td>
		<td><%= f.hd_picker :easter, { :date_format => "DD MM d, yy", html: { style: "width: 200px;", data: { microdata: "a value" } } }, :full_day_month %></td>
	</tr>
</table>
```

#### <a name="fho"></a>Form helper picker methods options ####
- :date_format - datepicker [format string](http://api.jqueryui.com/datepicker/)
	- default: "mm/dd/yy"
- :time_format - timepicker [format string](http://trentrichardson.com/examples/timepicker/)
	- default: "HH:mm"
- :html - attributes to be added to the input field
- :hd_opts - options to be applied to the picker object

##### Common :hd_opts
|                   | DatePicker | TimePicker | DatetimePicker |
| --------------    | ---------- | ---------- | -------------- |
| change_month      |     X      |            |       X        |
| change_year       |     X      |            |       X        |
| year_range        |     X      |            |       X        |
| alt_time_format*  |            |     X      |       X        |
| control_type      |            |     X      |       X        |
| hour_grid         |            |     X      |       X        |
| minute_grid       |            |     X      |       X        |
| second_grid       |            |     X      |       X        |
| separator         |            |            |       X        |
| current_text      |     X      |     X      |       X        |
| close_text        |     X      |     X      |       X        |
| time_suffix       |            |     X      |       X        |
| show_button_panel |     X      |     X      |       X        |
| default_date      |     X      |     X      |       X        |



\* *alt_time_format should be overridden when you need more precision than minutes for a datetime picker (e.g. "HH:mm:ss")*

#### Overriding Global Defaults ####
- There are five default values that can be overridden globally. To do so add a block similar to the following in your `config/environment.rb` file somewhere after the `Rails.application.initialize!` call\*:
```ruby
HotDateRails.config do |config|
  config.control_type = "slider" #or "select"
  config.hour_grid = "12"
  config.minute_grid = "15"
  config.second_grid = "30"
  config.date_format = "MM d, yy"
  config.time_format = "h:mm tt"
end
```
\* *Note that if you override the date and/or time format you should also edit the corresponding entries in your locale file(s)*

#### <a name="locales"></a>Base Set of included locale formats ####
```YAML
en:
	date:
  	formats:
      default: "%m/%d/%Y"
      full_month: "%B %-d, %Y"
      full_day_month: "%A %B %-d, %Y"
  time:
    formats:
      default: "%H:%M"
      datetime: "%m/%d/%Y %H:%M"
      datetime_w_seconds: "%-m/%-e/%Y %H:%M:%S"
      w_seconds: "%H:%M:%S"
      lc_merid: "%-l:%M %P"
      uc_merid: "%-l:%M %p"
```

#### Dynamically added inputs ###
If you're dynamically adding inputs to the DOM using the helpers (possibly for a modal dialog) you must call the Window.bindHDPickers() function.
```coffee-script
$( "#modal_dialog" ).load("/schedules/1/edit-in-modal", ->
    Window.bindHDPickers()
)
```

#### To run tests ####
```
rspec spec --tag ~@slider --tag ~@defaults
rspec spec --tag ~@slider --tag @defaults --order default
```

#### Credits ####
- This gem makes use of the [jQuery Timepicker Addon](https://github.com/trentrichardson/jQuery-Timepicker-Addon)

##### TODO #####
- See if we can get Selenium drag_by to work again. For now we're filtering out any specs that involve the slider
- Add convenience methods for common formats
- Add method that accepts both a picker format and a strftime format so custom locale formats don't need to be added by the user

