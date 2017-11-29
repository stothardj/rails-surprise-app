# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

has_geolocation = ->
  return 'geolocation' in navigator

$ ->
  $('#check-location').click ->
    have_geo = has_geolocation()
    console.log have_geo
    $('#output').text "Have geolocation: #{have_geo}"
    event.preventDefault()
