class PagesController < ApplicationController


  def launch

  end

  def home
  	@home_lyric = Lyric.all.order("RANDOM()").first
  	@home_campaign = Campaign.open.all.order("created_at ASC").last
  	@featured_users = User.featured.all.order("created_at DESC").take(2)
  	@home_posts = Post.all.order("created_at DESC")

  end

end
