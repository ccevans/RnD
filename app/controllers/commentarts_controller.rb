class CommentartsController < ApplicationController
	before_action :authenticate_user!
	before_action :all_commentarts, only: [:create, :destroy]
	before_action :set_commentarts, only: [:destroy]
	respond_to :html, :js, :json

	def create
		@art = Art.find(params[:art_id])
		@commentart = Commentart.create(params[:commentart].permit(:content))
		@commentart.user_id = current_user.id
		@commentart.art_id = @art.id

		if @commentart.save

		respond_to do |format|
    		format.html {redirect_to([@art.campaign, @art])}
    		format.json
    		format.js
    	end
    	
		else
			render 'new'
		end
	end

	def destroy
	    @commentart.destroy
	    redirect_to :back
	  end

	private

		  def all_commentarts
	    	@art = Art.find(params[:art_id])
	    	@commentarts = Commentart.where(art_id: @art)
	    end

	   def set_commentarts

	      @commentart = Commentart.find(params[:id])
	    end

end
