class ArtsController < ApplicationController
	before_action :tag_cloud, :only => [:index]
	load_and_authorize_resource :only => [:show, :edit, :update, :destroy]
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :set_campaign
	before_action :authenticate_user!, except: [:index, :show]
	impressionist :actions=>[:show,:index], :unique => [:impressionable_type, :impressionable_id, :session_hash]


	def index
		@arts = Art.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
		
		@rating = Rating.new(art_id: @art)

		@ratings = Rating.where(art_id: @art)

		@current_ratings = Rating.where(art_id: @art, user_id: current_user.id).all.order("created_at DESC")


		if @ratings.blank?
			@avg_rating = 0
		else
			@avg_rating = @ratings.average(:rate).round(2)
		end
		
	end

	def show
		@commentarts = Commentart.where(art_id: @art)
		@ratings = Rating.where(art_id: @art)
		
		@current_ratings = Rating.where(art_id: @art, user_id: current_user.id).all.order("created_at DESC")
		

		@random_art = Art.where.not(id: @art).order("RANDOM()").first

		@random_arts = Art.where.not(id: @art).order("RANDOM()").take(5)

		if @art == Art.last
			@next_art = Art.order(id: :asc).first
		else
			@next_art = Art.where("id > ?", @art).order(id: :asc).first
		end

		if @art == Art.first
			@previous_art = Art.order(id: :asc).first
		else
			@previous_art = Art.where("id < ?", @art).order(id: :desc).first
		end


		if @ratings.blank?
			@avg_rating = 0
		else
			@avg_rating = @ratings.average(:rate).round(2)
		end
	end

	def new
		@art = Art.new
	end

	def create
		@art = Art.new(post_params)
		@art.user_id = current_user.id
		@art.campaign_id = @campaign.id

		if @art.save
			redirect_to([@art.campaign, @art])
		else
			render 'new'
		end

	end

	def edit
	end

	def update
		if @art.update(post_params)
			redirect_to([@art.campaign, @art])
		else
			render 'edit'
		end

	end

	def destroy
		@art.destroy
		redirect_to root_path
	end

	def tagged
  		if params[:tag].present? 
    		@arts = Art.tagged_with(params[:tag]).order("created_at desc")
  		else 
    		@arts = Art.all.order("created_at desc")
  		end  
	end

	def tag_cloud
		
   		 @tags = Art.tag_counts_on(:tags)
  	end


	private

	def find_post
		@art = Art.find(params[:id])
	end

	def set_campaign
		@campaign = Campaign.find(params[:campaign_id])
	end

	def post_params
		params.require(:art).permit( :image, :description, :artist, :typeart, :link)
	end


end
