class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :all_comments, only: [:create, :destroy]
	before_action :set_comments, only: [:destroy]
	respond_to :html, :js, :json

	def create
		@lyric = Lyric.find(params[:lyric_id])
		@comment = Comment.create(params[:comment].permit(:content))
		@comment.user_id = current_user.id
		@comment.lyric_id = @lyric.id

		if @comment.save
			

		respond_to do |format|
    		format.html {redirect_to([@lyric.campaign, @lyric])}
    		format.json
    		format.js
    	end
		else
			render 'new'
		end
	end

	def destroy
	    @comment.destroy
	  end

	private

		  def all_comments
	    	@lyric = Lyric.find(params[:lyric_id])
	    	@comments = Comment.where(lyric_id: @lyric)
	    end

	   def set_comments
	      @comment = Comment.find(params[:id])
	    end
end
