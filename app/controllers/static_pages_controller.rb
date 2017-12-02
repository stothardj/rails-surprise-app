
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

def find_distance(coord1, coord2)
  return 3
end

class StaticPagesController < ApplicationController
  def home
  end

  def getlines
    name = params[:name]
    render :json => {:lines => DASH_LINES[name], :block => BLOCK_FOR_CLUE[name], :next => NEXT[name]}
  end

  def checkpos
    lat = params[:lat]
    lng = params[:lng]
    clue = params[:clue]
    destination = CLUE_DESTINATION[clue]
    dist = find_distance({:lat => lat, :lng => lng}, destination)
    render :json => {:test => "meow", :pos => "#{lat}x#{lng}", :clue => clue, :dist => dist}
  end
end
