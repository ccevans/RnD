class AdminlyricsController < ApplicationController

	load_and_authorize_resource :only => [:show, :new, :edit, :update, :destroy]
	before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show]
	

	def index
		@adminlyrics = Adminlyric.all.order("created_at DESC")
	end

	def show
		@commentlyrics = Commentlyric.where(adminlyric_id: @adminlyric)
	end

	def new
		@adminlyric = current_user.adminlyrics.build
	end

	def create
		@adminlyric = current_user.adminlyrics.build(post_params)

		if @adminlyric.save
			redirect_to @adminlyric
		else
			render 'new'
		end

	end

	def edit
		
	end

	def update

		if @adminlyric.update(post_params)
			redirect_to @adminlyric
		else
			render 'edit'
		end
	end

	def destroy
		@adminlyric.destroy
		redirect_to root_path
	end

	def upvote
		@adminlyric.upvote_by current_user
		redirect_to :back
	end

	def downvote
		@adminlyric.downvote_by current_user
		redirect_to :back
	end


	private

	def find_post
		@adminlyric = Adminlyric.find(params[:id])
	end

	def post_params
		params.require(:adminlyric).permit(:line, :description, :artist, :song, :album, :link)
	end

end
