$(document).on 'ready page:load', ->
  $("input.datepicker").each (i) ->
    $(this).datepicker
      altFormat: "yy-mm-dd"
      dateFormat: this.getAttribute("data-date-format") #"mm/dd/yy"
      altField: $(this).next()
      changeYear: true
      changeMonth: true

$(document).on 'ready page:load', ->
  $("input.datetimepicker").each (i) ->
    $(this).datetimepicker
      altField: $(this).next()
      altFieldTimeOnly: false
      altFormat: "yy-mm-dd"
      altTimeFormat: "HH:mm"
      dateFormat: "mm/dd/yy"
      timeFormat: "HH:mm"

$(document).on 'ready page:load', ->
  $("input.timepicker").each (i) ->
    $(this).datetimepicker
      altField: $(this).next()
      altFieldTimeOnly: false
      timeFormat: this.getAttribute("data-time-format")
      timeOnly: true #when false time is properly selected
      hourGrid: this.getAttribute("data-hour-grid")
      minuteGrid: this.getAttribute("data-minute-grid")
      secondGrid: this.getAttribute("data-second-grid")
      defaultValue: this.value
    #debugger
      
      #
      #altDateFormat: "yy-mm-dd"
      #altTimeFormat: this.getAttribute("data-time-format") #default is same as timeFormat








# dateFormat
# timeFormat & altTimeFormat (should probably be same)
# hourGrid, minuteGrid, secondGrid

# Datepicker Only
# changeYear, changeMonth  

#Timepicker Only
# timeOnly - should only be passed to override showing calendar on timepicker


# $(document).on 'ready page:load', ->
#   $("input.timepicker").each (i) ->
#     $(this).timepicker
#       altField: $(this).next()
#       hourGrid: 6
#       minuteGrid: 10
#       secondGrid: 10
#       timeFormat: this.getAttribute("data-time-format")
