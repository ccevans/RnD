class CommentartsController < ApplicationController
before_action :authenticate_user!

	def create
		@art = Art.find(params[:art_id])
		@commentart = Commentart.create(params[:commentart].permit(:content))
		@commentart.user_id = current_user.id
		@commentart.art_id = @art.id

		if @commentart.save
			redirect_to([@art.campaign, @art])
		else
			render 'new'
		end
	end

end
