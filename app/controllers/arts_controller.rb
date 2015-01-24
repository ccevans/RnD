class ArtsController < ApplicationController
	before_action :tag_cloud, :only => [:index, :filter]
	has_scope :by_tags
	load_and_authorize_resource :only => [:show, :edit, :update, :destroy]
	before_action :find_post, only: [:show, :edit, :update, :destroy, :voteof1, :voteof2, :voteof3, :voteof4, :voteof5]
	before_action :set_campaign, except: [:voteof1, :voteof2, :voteof3, :voteof4, :voteof5]
	before_action :authenticate_user!, except: [:index, :show, :tagged]
	impressionist :actions=>[:show,:index], :unique => [:impressionable_type, :impressionable_id, :session_hash]
	


	def index
		case params[:sort_by]
	      when 'most_liked'
	        @arts = apply_scopes(Art).all.order(:cached_weighted_total => :desc).paginate(:page => params[:page], :per_page => 10)
	    	when 'most_viewed'
	        @arts = apply_scopes(Art).all.order(:counter_cache => :desc).paginate(:page => params[:page], :per_page => 10)
	      when 'most_recent'
	        @arts = apply_scopes(Art).all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
	      else
			@arts = apply_scopes(Art).all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
	    end
		
	end

	def show
		@commentarts = Commentart.where(art_id: @art)
		
		@random_art = Art.where.not(id: @art).order("RANDOM()").first

		@random_arts = Art.where.not(id: @art).order("RANDOM()").take(5)

		if @art == Art.last
			@next_art = Art.order(id: :asc).first
		else
			@next_art = Art.where("id > ?", @art).order(id: :asc).first
		end

		if @art == Art.first
			@previous_art = Art.order(id: :asc).last
		else
			@previous_art = Art.where("id < ?", @art).order(id: :desc).first
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


	def filter
  		if params[:tag].present? 
    		@arts = Art.tagged_with(params[:tag]).order("created_at desc").paginate(:page => params[:page], :per_page => 10)
  		else 
    		@arts = apply_scopes(Art).all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  		end 
	end

	def tag_cloud
		
   		 @tags = Art.tag_counts_on(:tags)
  	end

  	def voteof1
		@art.vote_by :voter => current_user, :vote => 'one', :vote_weight => 1
		redirect_to :back
   
	end

	def voteof2
		@art.vote_by :voter => current_user, :vote => 'two', :vote_weight => 2
		redirect_to :back
	end

	def voteof3
		@art.vote_by :voter => current_user, :vote => 'three', :vote_weight => 3
		redirect_to :back
	end

	def voteof4
		@art.vote_by :voter => current_user, :vote => 'four', :vote_weight => 4
		redirect_to :back
	end

	def voteof5
		@art.vote_by :voter => current_user, :vote => 'five', :vote_weight => 5
		redirect_to :back
	end


	private

	def find_post
		@art = Art.find(params[:id])
	end

	def set_campaign
		@campaign = Campaign.find(params[:campaign_id])
	end

	def post_params
		params.require(:art).permit( :image, :description, :artist, :typeart, :link, :tag_list)
	end


end
