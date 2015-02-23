class LyricsController < ApplicationController
	
	before_action :tag_cloud, :only => [:index, :tagged]
	has_scope :by_tags
	has_scope :by_campaign, :using => [:campaign_id]
	load_and_authorize_resource :only => [:show, :edit, :update, :destroy]
	before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :set_campaign, except: [:upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show, :tagged]
	impressionist :actions => [:show,:index], :unique => [:impressionable_type, :impressionable_id, :session_hash]

	respond_to :html, :json, :js

	

	def index

		case params[:sort_by]
	      when 'most_liked'
	        @lyrics = apply_scopes(Lyric).all.order(:cached_votes_up => :desc).paginate(:page => params[:page], :per_page => 10)
	       when 'most_viewed'
	        @lyrics = apply_scopes(Lyric).all.order(:counter_cache => :desc).paginate(:page => params[:page], :per_page => 10)
	      when 'most_recent'
	        @lyrics = apply_scopes(Lyric).all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
	      else
	        @lyrics = apply_scopes(Lyric).all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
	    end




	    @posts = Post.all.order(:counter_cache => :desc).take(2)

	   	@arts = Art.all.order(:cached_weighted_total => :desc).take(2)

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

	def show
		@comments = Comment.where(lyric_id: @lyric)
		@random_lyric = Lyric.where.not(id: @lyric).order("RANDOM()").first
		@random_lyrics = Lyric.where.not(id: @lyric).order("RANDOM()").take(5)

		if @lyric == Lyric.last
			@next_lyric = Lyric.order(id: :asc).first
		else
			@next_lyric = Lyric.where("id > ?", @lyric).order(id: :asc).first
		end

		if @lyric == Lyric.first
			@previous_lyric = Lyric.order(id: :asc).last
		else
			@previous_lyric = Lyric.where("id < ?", @lyric).order(id: :desc).first
		end
		
	end

	def new
		@lyric = Lyric.new
	end

	def create
		@lyric = Lyric.new(post_params)
		@lyric.user_id = current_user.id
		@lyric.campaign_id = @campaign.id

		if @lyric.save
			redirect_to([@lyric.campaign, @lyric])
		else
			render 'new'
		end

	end

	def edit
	end

	def update
		if @lyric.update(post_params)
			redirect_to([@lyric.campaign, @lyric])
		else
			render 'edit'
		end

	end

	def destroy
		@lyric.destroy
		redirect_to root_path
	end

	def upvote
		@lyric.upvote_by current_user

		 respond_to do |format|
    		format.html {redirect_to :back }
    		format.json { render json: { count: @lyric.cached_votes_up, count2: @lyric.cached_votes_down }}
    	format.js { render :layout => false }
    
    	end

	end

	def downvote
		@lyric.downvote_by current_user

			 respond_to do |format|
    		format.html {redirect_to :back }
    		format.json { render json: {  count: @lyric.cached_votes_up, count2: @lyric.cached_votes_down } }
    		format.js { render :layout => false }
    	end
	end

	def tagged

  		if params[:tag].present? 
    		@lyrics = Lyric.tagged_with(params[:tag]).order("created_at desc").paginate(:page => params[:page], :per_page => 10)
  		else 
    		@lyrics = apply_scopes(Lyric).all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)

  		end  
	end

	def tag_cloud
		
   		 @tags = Lyric.tag_counts_on(:tags)
  	end

  	 def all_following
		   @user = User.find_by_username(params[:username])
		   @users = User.find_by_username(params[:username]).all_following
		end

		def all_follows
		   @user = User.find_by_username(params[:username])
		   @users = User.find_by_username(params[:username]).followers
		end


	private


	def find_post
		@lyric = Lyric.find(params[:id])
	end

	def set_campaign
		@campaign = Campaign.find(params[:campaign_id])
	end


	def post_params
		params.require(:lyric).permit(:line, :description, :artist, :song, :album, :link, :tag_list, :chosen)
	end

end
