$(document).on 'ready page:load', ->
  $("input.datepicker").each (i) ->
    $(this).datepicker
      altFormat: "yy-mm-dd"
      dateFormat: "mm/dd/yy"
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
      altTimeFormat: this.getAttribute("data-time-format")
      timeFormat: this.getAttribute("data-time-format")
      timeOnly: true
      hourGrid: 6
      minuteGrid: 20
      secondGrid: 20
  

# $(document).on 'ready page:load', ->
#   $("input.timepicker").each (i) ->
#     $(this).timepicker
#       altField: $(this).next()
#       hourGrid: 6
#       minuteGrid: 10
#       secondGrid: 10
#       timeFormat: this.getAttribute("data-time-format")
      

