class CommentsController < ApplicationController
	before_action :authenticate_user!

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
end
