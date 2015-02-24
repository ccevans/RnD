class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show]
	has_scope :by_tags
	before_action :tag_cloud, :only => [:index, :tagged]
	load_and_authorize_resource :only => [:show, :edit, :update, :destroy]
	impressionist :actions => [:show,:index], :unique => [:impressionable_type, :impressionable_id, :session_hash]
	respond_to :html, :json, :js

	def index
		case params[:sort_by]
	      when 'most_liked'
	        @posts = apply_scopes(Post).all.order(:cached_votes_up => :desc)
	    when 'most_viewed'
	        @posts = apply_scopes(Post).all.order(:counter_cache => :desc)
	      when 'most_recent'
	        @posts = apply_scopes(Post).all.order("created_at DESC")
	      else
	        @posts = apply_scopes(Post).all.order("created_at DESC")
	    end
	end

	def show
		@commentposts = Commentpost.where(post_id: @post)

		@random_posts = Post.where.not(id: @post).order("RANDOM()").take(5)

		if @post == Post.last
			@next_post = Post.order(id: :asc).first
		else
			@next_post = Post.where("id > ?", @post).order(id: :asc).first
		end

		if @post == Post.first
			@previous_post = Post.order(id: :asc).last
		else
			@previous_post = Post.where("id < ?", @post).order(id: :desc).first
		end
		
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit

	end

	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	def upvote
		@post.upvote_by current_user

		respond_to do |format|
    		format.html {redirect_to :back }
    		format.json { render json: { count: @post.cached_votes_up, count2: @post.cached_votes_down }}
    		format.js { render :layout => false }
    	end

	end

	def downvote
		@post.downvote_by current_user
		
		respond_to do |format|
    		format.html {redirect_to :back }
    		format.json { render json: {  count: @post.cached_votes_up, count2: @post.cached_votes_down } }
    		format.js { render :layout => false }
    	end
	end

	def tagged

  		if params[:tag].present? 
    		@posts = Post.tagged_with(params[:tag]).order("created_at desc").paginate(:page => params[:page], :per_page => 10)
  		else 
    		@posts = apply_scopes(Post).all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)

  		end  
	end

	def tag_cloud
		
   		 @tags = Post.tag_counts_on(:tags)
  	end

	



private

	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :description, :link, :typeof, :approve, :image, :videolink, :audiolink, :tag_list)
	end

end
