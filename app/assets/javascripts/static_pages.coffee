# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

has_geolocation = ->
  return !!navigator.geolocation

got_pos = (pos) ->
  console.log 'Got pos!' 
  lat = pos.coords.latitude
  lng = pos.coords.longitude
  $('#output').text "(#{lat}, #{lng})"

got_pos_fail = ->
  $('#output').text 'Getting your location failed'

$ ->
  $('#check-location').click ->
    have_geo = has_geolocation()
    console.log have_geo
    navigator.geolocation.getCurrentPosition(got_pos, got_pos_fail);
    event.preventDefault()
