class CommentlyricsController < ApplicationController
	before_action :authenticate_user!

	def create
		@adminlyric = Adminlyric.find(params[:adminlyric_id])
		@commentlyric = Commentlyric.create(params[:commentlyric].permit(:content))
		@commentlyric.user_id = current_user.id
		@commentlyric.adminlyric_id = @adminlyric.id

		if @commentlyric.save
			redirect_to adminlyric_path(@adminlyric)
		else
			render 'new'
		end
	end
end
