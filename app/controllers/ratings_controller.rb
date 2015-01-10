class RatingsController < ApplicationController
	before_action :authenticate_user!


	def create
		@art = Art.find(params[:art_id])
		@rating = Rating.create(params[:rating].permit(:rate, :params, :art_id))
		@rating.user_id = current_user.id
		@rating.art_id = @art.id

		if @rating.save
			redirect_to :back
		else
			render 'new'
		end
	end
end