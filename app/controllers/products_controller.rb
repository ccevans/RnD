class ProductsController < ApplicationController



	def index
		shop_url = "https://904f9b0264e54b02b853afb4449f41d1:e6c5e55a93a848105a2194a645ee8a65@rhymes-and-designs.myshopify.com/admin"
		ShopifyAPI::Base.site = shop_url
		@products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
	end

end
