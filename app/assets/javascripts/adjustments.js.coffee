# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
 
window.adjustments = {}

window.adjustments.itemFormatResult = (item) ->
  "#{item.name}: #{item.aliases}"

window.adjustments.itemFormatSelection = (item) ->
  item.name
