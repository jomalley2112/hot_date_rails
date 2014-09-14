$(document).on 'ready page:load', ->
  $("input.datepicker").each (i) ->
    $(this).datepicker
      showTimepicker: false
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
    defOpts = {timeOnly: true
    altField: $(this).next()
    altFieldTimeOnly: false
    defaultValue: this.value}
    setPickerOptions( this, defOpts )
    
      

setPickerOptions = (input, defOpts) ->
  userOpts = $(input).data()
  allOpts = $.extend({}, defOpts, userOpts)
  $(input).datetimepicker(allOpts)
  







#dataObj = input.data()
# $.each(dataObj, function (k,v) {
#     console.log(k+"="+v)
# });

# datepicker=[object Object] VM5046:3
# timeFormat=null VM5046:3
# secondGrid=59 VM5046:3
# minuteGrid=59 VM5046:3
# jom=HERE VM5046:3
# hourGrid=23 VM5046:3
# dateFormat=DD MM d, yy 



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
