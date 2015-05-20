class PagesController < ApplicationController


  def launch

  end

  def home
  	@home_lyric = Lyric.all.order("RANDOM()").first
  	@home_campaign = Campaign.open.all.order("created_at DESC").last


  end

end
