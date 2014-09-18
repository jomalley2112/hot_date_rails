$(document).on 'ready page:load', ->
  $("input.datepicker").each (i) ->
    defOpts = {
    altFormat: "yy-mm-dd"
    altField: $(this).next()
    changeYear: true
    changeMonth: true}
    setDatePickerOptions( this, defOpts )

$(document).on 'ready page:load', ->
  $("input.datetimepicker").each (i) ->
    defOpts = {altField: $(this).next()
    altFieldTimeOnly: false
    altFormat: "yy-mm-dd"
    altTimeFormat: "HH:mm"}
    setPickerOptions( this, defOpts )

$(document).on 'ready page:load', ->
  $("input.timepicker").each (i) ->
    defOpts = {timeOnly: true
    altField: $(this).next()
    altFieldTimeOnly: false
    defaultValue: this.value}
    setPickerOptions( this, defOpts )
    
      
setPickerOptions = (input, defOpts) ->
  userOpts = $(input).data()
  allOpts = $.extend({}, defOpts, userOpts)
  $(input).datetimepicker(allOpts)

setDatePickerOptions = (input, defOpts) ->
  userOpts = $(input).data()
  allOpts = $.extend({}, defOpts, userOpts)
  $(input).datepicker(allOpts)


#dataObj = input.data()
# $.each(dataObj, function (k,v) {
#     console.log(k+"="+v)
# });


# $(document).on 'ready page:load', ->
#   $("input.timepicker").each (i) ->
#     $(this).timepicker
#       altField: $(this).next()
#       hourGrid: 6
#       minuteGrid: 10
#       secondGrid: 10
#       timeFormat: this.getAttribute("data-time-format")
