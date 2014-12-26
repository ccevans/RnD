class ArtsController < ApplicationController
	load_and_authorize_resource :only => [:show, :edit, :update, :destroy]
	before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show]
	impressionist :actions=>[:show,:index], :unique => [:impressionable_type, :impressionable_id, :session_hash]

	def index
		@arts = Art.all.order("created_at DESC")
	end

	def show
		@commentarts = Commentart.where(art_id: @art)
	end

	def new
		@art = current_user.arts.build
	end

	def create
		@art = current_user.arts.build(post_params)

		if @art.save
			redirect_to @art
		else
			render 'new'
		end

	end

	def edit
	end

	def update
		if @art.update(post_params)
			redirect_to @art
		else
			render 'edit'
		end

	end

	def destroy
		@art.destroy
		redirect_to root_path
	end

	def upvote
		@art.upvote_by current_user
		redirect_to :back
	end

	def downvote
		@art.downvote_by current_user
		redirect_to :back
	end


	private

	def find_post
		@art = Art.find(params[:id])
	end

	def post_params
		params.require(:art).permit( :image, :description, :artist, :typeart, :link)
	end


end
