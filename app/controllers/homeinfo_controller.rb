class HomeinfoController < ApplicationController
	has_scope :open
	


	def index
		 @posts = Post.all.order(:counter_cache => :desc).take(2)

		 

		 @open_campaigns = Campaign.open.all.order("created_at DESC").take(3)

		 shop_url = "https://904f9b0264e54b02b853afb4449f41d1:e6c5e55a93a848105a2194a645ee8a65@rhymes-and-designs.myshopify.com/admin"
		 ShopifyAPI::Base.site = shop_url
		 @products = ShopifyAPI::Product.find(:all, :params => {:limit => 4})

		 @users = User.all.order("RANDOM()").take(4)

		 respond_to do |format|
    		format.html
    		format.json
    		format.js
    	end

	end

	private

	def set_campaign
		@campaign = Campaign.find(params[:campaign_id])
	end

end
