class CommentpostsController < ApplicationController
	before_action :authenticate_user!
	before_action :all_commentposts, only: [:create, :destroy]
	before_action :set_commentposts, only: [:destroy]
	respond_to :html, :js, :json

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

	def destroy
	    @commentpost.destroy
	    redirect_to :back
	  end

	private

		  def all_commentposts
	    	@post = Post.find(params[:post_id])
	    	@commentposts = Commentpost.where(post_id: @post)
	    end

	   def set_commentposts

	      @commentpost = Commentpost.find(params[:id])
	    end
end
