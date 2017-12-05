
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
  "fetch" => [
    "Fetch is the classic game.",
    "It existed long before even Mark Twain.",
    "Yet though in such a competition I'm sure to take gold",
    "Here some great challenges did unfold",
  ],
  "outro" => [
    "Hope you've been having fun so far!",
    "I've only got one last clue.",
  ],
  "cold" => [
    "Am I cold or am I sweet?",
    "Or am I just something to eat?",
    "The next clue is buried where you did ....",
  ],
  "final" => [
    "You did it!",
    "You completed the scavenger hunt!",
    "But wait, what was the buried treasure?",
  ],
  "final2" => [
    "I've been digging up memories!",
    "Little bits of your past I hope you remember."
  ],
  "final3" => [
    "And hopefully, make many more of....",
  ],
  "finally" => [
    "Happy Anniversary!!!",
  ],
}

SUCCESS_LINES = {
  "bestseat" => [
    "Yes, here it is!",
    "It was Jake's idea to call hiself the best seat, sorry about him.",
  ],
  "fetch" => [
    "Wohoo!",
    "Offbeat Olympics looks like it was a ton of fun!",
    "(I check the website regularly)",
  ],
  "cold" => [
    "Aww, you too met here",
    "Was the gelato here as good as what we had in Venice?",
  ],
}

REJECTION_LINES = {
  "bestseat" => [
    [
      "No, this isn't what I meant.",
      "You've read the clue all inside out.",
    ],
    [
      "Nothing here.",
      "You need to Pokemon Go back to the right city.",
    ],
    [
      "The place sounded like it would be full of trees."
    ],
  ],
  "fetch" => [
    [
      "This isn't right.",
      "Games are popular worldwide,",
      "but you shouldn't have to go too far to find these ones.",
    ],
    [
      "No...",
      "Maybe with a different clue you'd be better off.",
      "Beats me what it should have been though.",
    ]
  ],
  "cold" => [
    [
      "You misread the clue,",
      "But don't be blue.",
      "The truth is there waiting for you.",
    ],
    [
      "Well I'm not cold.",
      "Huskies like me never get cold.",
      "That doesn't mean this place isn't cold though.",
    ],
    [
      "Row, row, row your boat....",
      "When can I practice rowing again?",
    ],
  ],
}

NEXT = {
  "intro" => "rules",
  "rules" => "bestseat",
  "bestseat" => "fetch",
  "fetch" => "outro",
  "outro" => "cold",
  "cold" => "final",
  "final" => "final2",
  "final2" => "final3",
  "final3" => "finally",
}

BLOCK_FOR_CLUE = {
  "intro" => false,
  "rules" => false,
  "bestseat" => true,
  "fetch" => true,
  "outro" => false,
  "cold" => true,
  "final" => false,
  "final2" => false,
  "final3" => false,
  "finally" => false,
}

CLUE_DESTINATION = {
  "bestseat" => {:lat => 37.486731, :lng => -122.229672},
  "fetch" => {:lat => 37.378095, :lng => -122.042012},
  "cold" => {:lat => 37.393212, :lng => -122.079056},
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
    success = dist < 0.2
    lines = if success then SUCCESS_LINES[clue] else REJECTION_LINES[clue].sample end
    response = {:success => success, :lines => lines}
    response[:next] = NEXT[clue] if success
    render :json => response
  end
end
