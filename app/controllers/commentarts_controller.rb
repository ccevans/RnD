class CommentartsController < ApplicationController
before_action :authenticate_user!

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

end
