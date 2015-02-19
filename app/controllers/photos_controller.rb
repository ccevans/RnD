class PhotosController < ApplicationController
	before_action :authenticate_user!
	before_action :all_photos, only: [:create, :destroy]
	 before_action :set_photos, only: [:destroy]
	  respond_to :html, :js, :json


	  def new
	    @photo = Photo.new
	  end

	  def create
	    @photo  = Photo.create(photo_params)
	    @photo.user_id = current_user.id

	    if @photo.save
			

		respond_to do |format|
    		format.html {redirect_to :back}
    		format.json
    		format.js
    	end
		else
			render 'new'
		end
	  end

	  def destroy
	    @photo.destroy
	  end


	  private

	    def all_photos
	    	@user = User.find_by_username(params[:id])
	      @photos = Photo.all.where(user_id: @user)
	    end

	    def set_photos
	      @photo = Photo.find(params[:id])
	    end


	    def photo_params
	      params.require(:photo).permit(:image, :link)
	    end


end


