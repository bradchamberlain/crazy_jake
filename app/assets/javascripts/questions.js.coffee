# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(".qtype").click ->
    if @value == "customized"
      $(".customized_question").show()
    else
      $(".customized_question").hide()
