

loadDatePicker = () ->
  $("input.datepicker").each (i) ->
    defOpts = {
    altFormat: "yy-mm-dd"
    altField: $(this).next()
    changeYear: true
    changeMonth: true}
    setDatePickerOptions( this, defOpts )
  
loadTimePicker = () ->
  $("input.timepicker").each (i) ->
    defOpts = {timeOnly: true
    altField: $(this).next()
    altFieldTimeOnly: false
    defaultValue: this.value}
    setPickerOptions( this, defOpts )

loadDatetimePicker = () ->
  $("input.datetimepicker").each (i) ->
    defOpts = {altField: $(this).next()
    altFieldTimeOnly: false
    altFormat: "yy-mm-dd"
    altTimeFormat: "HH:mm"}
    setPickerOptions( this, defOpts )


Window.bindHDPickers = () ->
  loadDatePicker()
  loadTimePicker()
  loadDatetimePicker()

$(document).on 'ready page:load', ->
  Window.bindHDPickers()
  
setPickerOptions = (input, defOpts) ->
  userOpts = $(input).data()
  allOpts = $.extend({}, defOpts, userOpts)
  $(input).datetimepicker(allOpts)

setDatePickerOptions = (input, defOpts) ->
  userOpts = $(input).data()
  allOpts = $.extend({}, defOpts, userOpts)
  $(input).datepicker(allOpts)
