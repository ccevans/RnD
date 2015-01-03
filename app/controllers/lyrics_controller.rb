class LyricsController < ApplicationController
	
	before_action :tag_cloud, :only => [:index]
	has_scope :by_tags
	load_and_authorize_resource :only => [:show, :edit, :update, :destroy]
	before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :set_campaign
	before_action :authenticate_user!, except: [:index, :show]
	impressionist :actions=>[:show,:index], :unique => [:impressionable_type, :impressionable_id, :session_hash]
	
	
	

	def index
		@lyrics = apply_scopes(Lyric).all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
	end

	def show
		@comments = Comment.where(lyric_id: @lyric)
		@random_lyric = Lyric.where.not(id: @lyric).order("RANDOM()").first
		
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
		redirect_to([@lyric.campaign, @lyric])
	end

	def downvote
		@lyric.downvote_by current_user
		redirect_to([@lyric.campaign, @lyric])
	end

	def tagged
  		if params[:tag].present? 
    		@lyrics = Lyric.tagged_with(params[:tag]).order("created_at desc")
  		else 
    		@lyrics = Lyric.all.order("created_at desc")
  		end  
	end

	def tag_cloud
		
   		 @tags = Lyric.tag_counts_on(:tags)
  	end


	private

	def find_post
		@lyric = Lyric.find(params[:id])
	end

	def set_campaign
		@campaign = Campaign.find(params[:campaign_id])
	end


	def post_params
		params.require(:lyric).permit(:line, :description, :artist, :song, :album, :link, :tag_list)
	end

end
