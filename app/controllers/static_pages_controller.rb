class StaticPagesController < ApplicationController
  def home
  end

  def checkpos
    lat = params[:lat]
    lng = params[:lng]
    clue = params[:clue]
    render :json => {:test => "meow", :pos => "#{lat}x#{lng}", :clue => clue}
  end
end
