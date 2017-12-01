
DASH_LINES = {
  "intro" => [
    "Hi there,",
    "I know it's a special day for you, so I've put together a treat.",
    "It's a scavenger hunt!",
    "I've been sneaking out, burying treasures all over the place.",
    "Follow my hints to find out where I hid them.",
    "Once we get there ask me to dig, and I'll dig up the treasure I've left buried there.",
    "So are you ready to play a game?",
  ],
  "bestseat" => [
    "So here's the first clue, I tried to make it rhyme:",
    "You had a pretty good seat at Lion King, sitting in row number 2.",
    "But first, you and Jake visited here, more than one time.",
    "It was here you had the best seat in the house, reserved for just you.",
  ],
}

NEXT = {
  "intro" => "bestseat"
}

BLOCK_FOR_CLUE = {
  "intro" => false,
  "bestseat" => true,
}

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
    render :json => {:test => "meow", :pos => "#{lat}x#{lng}", :clue => clue}
  end
end
