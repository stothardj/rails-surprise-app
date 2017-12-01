# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

show_line_handler = null

clue = 'intro'

lines = [
        "Hi there,",
        "I know it's a special day for you, so I've put together a treat.",
        "It's a scavenger hunt!",
        "Here's how it's going to work.",
        "First I'll give you a clue. Use this to figure out where to go. Once we get there ask me to dig, and I'll dig up the treasure I've left buried there.",
        "So are you ready to play a game?",
]

has_geolocation = ->
  return !!navigator.geolocation

got_pos = (pos) ->
  console.log 'Got pos!' 
  lat = pos.coords.latitude
  lng = pos.coords.longitude
  $('#output').text "(#{lat}, #{lng})"
  $.ajax({url: "/checkpos", data: {
      'lat': lat, 'lng': lng, 'clue': clue}}).done (response) ->
    console.log "Response #{JSON.stringify(response)}"

got_pos_fail = ->
  $('#output').text 'Getting your location failed'

show_line = ->
  if lines.length
    content = $('.speech-content')
    content.append "<p class='dash-line'>#{lines.shift()}</p>"
    content.scrollTop content.prop('scrollHeight')
  else
    window.clearInterval(show_line_handler)
    show_line_handler = null

$ ->
  show_line_handler = window.setInterval(show_line, 2000)

  $('#check-location').click ->
    have_geo = has_geolocation()
    console.log have_geo
    # navigator.geolocation.getCurrentPosition(got_pos, got_pos_fail);
    got_pos({coords: {latitude: 300, longitude: 100}})
    event.preventDefault()
