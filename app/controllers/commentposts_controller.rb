class CommentpostsController < ApplicationController
	before_action :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		@commentpost = Commentpost.create(params[:commentpost].permit(:content))
		@commentpost.user_id = current_user.id
		@commentpost.post_id = @post.id

		if @commentpost.save

		respond_to do |format|
    		format.html {redirect_to post_path(@post)}
    		format.json
    		format.js
    	end
		else
			render 'new'
		end
	end
end
