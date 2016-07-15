# Start application.js
#
#= require jquery2
#= require jquery-ui
#= require jquery_ujs
#= require hot_date_rails
#= require_tree .

$ ->
  modal_dialog = $( "#modal_dialog" ).dialog(
    autoOpen: false,
    height: 500,
    width: 500,
    modal: true,
    close: ->
      $( "#modal_dialog" ).html("")
  )
  
  
  $('body').on("click", "a#open_edit_modal", (event) ->
    event.preventDefault()
    modal_dialog.dialog( "open" ) 
    $( "#modal_dialog" ).load("/schedules/1/edit-in-modal", ->
    	Window.bindHDPickers()
    	)
  ) 