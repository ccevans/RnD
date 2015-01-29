class CommentlyricsController < ApplicationController
	before_action :authenticate_user!

	respond_to :html, :json, :js

	def create
		@adminlyric = Adminlyric.find(params[:adminlyric_id])
		@commentlyric = Commentlyric.create(params[:commentlyric].permit(:content))
		@commentlyric.user_id = current_user.id
		@commentlyric.adminlyric_id = @adminlyric.id

		if @commentlyric.save

		respond_to do |format|
    		format.html {redirect_to adminlyric_path(@adminlyric) }
    		format.json
    		format.js 
    	end

		else
			render 'new'
		end
	end
end
