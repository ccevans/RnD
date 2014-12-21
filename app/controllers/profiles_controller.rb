class ProfilesController < ApplicationController
  def show

  	@user = User.find_by_username(params[:id])
  	if @user
  		@lyrics = @user.lyrics.all
  		render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end

  end
end
