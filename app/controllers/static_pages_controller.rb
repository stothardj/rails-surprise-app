
DASH_LINES = {
  "intro" => [
    "Hi there,",
    "I know it's a special day for you, so I've put together a treat.",
    "It's a scavenger hunt!",
  ],
  "rules" => [
    "I've been sneaking out, burying treasures all over the place.",
    "Follow my hints to find out where I hid them.",
    "Once we get there ask me to dig, and I'll dig up the treasure I've left buried there.",
    "So are you ready to play a game?",
  ],
  "bestseat" => [
    "This is exciting! Here's the first clue:",
    "You had a pretty good seat at Lion King, sitting in row number 2.",
    "But before that, you and Jake visited here.",
    "And it was here you had the best seat in the house!",
    "It was reserved for just you.",
  ],
}

NEXT = {
  "intro" => "rules",
  "rules" => "bestseat"
}

BLOCK_FOR_CLUE = {
  "intro" => false,
  "rules" => false,
  "bestseat" => true,
}

CLUE_DESTINATION = {
  "bestseat" => {:lat => 37.486731, :lng => -122.229672},
}

EARTH_RADIUS_MILES = 3959

def to_radians(deg)
  deg * Math::PI / 180
end

def find_distance(coord1, coord2)
  lat1 = to_radians coord1[:lat]
  lng1 = to_radians coord1[:lng]
  lat2 = to_radians coord2[:lat]
  lng2 = to_radians coord2[:lng]
  lat_diff = (lat1 - lat2).abs
  lng_diff = (lng1 - lng2).abs
  a = Math.sin(lat_diff/2)**2 + Math.cos(lat1) * Math.cos(lat2) * Math.sin(lng_diff/2) ** 2
  c = 2 * Math.asin(Math.sqrt a)
  EARTH_RADIUS_MILES * c
end

class StaticPagesController < ApplicationController
  def home
  end

  def getlines
    name = params[:name]
    render :json => {:lines => DASH_LINES[name], :block => BLOCK_FOR_CLUE[name], :next => NEXT[name]}
  end

  def checkpos
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    clue = params[:clue]
    destination = CLUE_DESTINATION[clue]
    dist = find_distance({:lat => lat, :lng => lng}, destination)
    render :json => {:test => "meow", :pos => "#{lat}x#{lng}", :clue => clue, :dist => dist}
  end
end
