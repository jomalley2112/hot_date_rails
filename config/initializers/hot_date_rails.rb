HotDateRails.config do |config|
	config.control_type = "slider" #or "select"
	config.hour_grid = "23"
	config.minute_grid = "59"
	config.second_grid = "59"
	config.date_format = "mm/dd/yy"
	config.time_format = "HH:mm"
end

#Use dropdowns instead of grids for hour, minute and second
# HotDateRails.config do |config|
# 	config.control_type = "select"
# 	config.hour_grid = "0"
# 	config.minute_grid = "0"
# 	config.second_grid = "0"
# 	config.date_format = "mm/dd/yy"
# 	config.time_format = "HH:mm"
# end