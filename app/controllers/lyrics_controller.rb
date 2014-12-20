class LyricsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]

	def index
		@lyrics = Lyric.all.order("created_at DESC")
	end

	def show

	end

	def new
		@lyric = Lyric.new 
	end

	def create
		@lyric = Lyric.new(post_params)

		if @lyric.save
			redirect_to @lyric
		else
			render 'new'
		end

	end

	def edit
	end

	def update
		if @lyric.update(post_parmas)
			redirect_to @lyric
		else
			render 'edit'
		end

	end

	def destroy
		@lyric.destroy
		redirect_to root_path
	end

	private

	def find_post
		@lyric = Lyric.find(params[:id])
	end

	def post_params
		params.require(:lyric).permit(:line, :description, :artist, :song, :album, :link)
	end

end
