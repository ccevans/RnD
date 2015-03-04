class VideosController < ApplicationController
	before_action :find_video, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index]
	has_scope :approve

	def index
		@videos = Video.all.order("created_at DESC")
	end

	def new
		@video = Video.new
	end

	def create
		@video = Video.new(video_params)
		@video.user_id = current_user.id

		if @video.save
			redirect_to :back
		else
			render 'new'
		end

	end

	def edit

	end

	def update
		if @video.update(video_params)
			redirect_to @video
		else
			render 'edit'
		end
	end

	def destroy
		@video.destroy
		redirect_to root_path
	end


	private

		def find_video
			@video = Video.find(params[:id])
		end

		def video_params
			params.require(:video).permit(:title, :videolink, :approve, :image)
		end
end
