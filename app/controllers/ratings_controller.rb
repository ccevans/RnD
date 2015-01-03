class RatingsController < ApplicationController
	before_action :authenticate_user!


	def create
		@art = Art.find(params[:art_id])
		@rating = Rating.create(params[:rating].permit(:rate))
		@rating.user_id = current_user.id
		@rating.art_id = @art.id

		if @rating.save
			redirect_to([@art.campaign, @art])
		else
			render 'new'
		end
	end
end