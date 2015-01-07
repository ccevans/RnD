class ProfilesController < ApplicationController

	before_action :find_post, only: [:show, :follow, :unfollow]

  def show

  	@user = User.find_by_username(params[:id])
  	if @user
      
  		@lyrics = @user.lyrics.all
      @arts = @user.arts.all
  		render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end

  end

  def all_following
   @user = User.find_by_username(params[:username])
   @users = User.find_by_username(params[:username]).all_following
end

def all_follows
   @user = User.find_by_username(params[:username])
   @users = User.find_by_username(params[:username]).followers
end

def follow
  @user = User.find_by_username(params[:id])

  if current_user
    if current_user == @user

      flash[:alert] = "You cannot follow yourself."
      redirect_to :back
    else
      current_user.follow(@user)
      redirect_to :back
     
      flash[:notice] = "You are now following #{@user.username}."
    end
  else
    flash[:alert] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.username}.".html_safe
  end
end

def unfollow
  @user = User.find_by_username(params[:id])

  if current_user
    current_user.stop_following(@user)
    redirect_to :back
    flash[:notice] = "You are no longer following #{@user.username}."
  else
    flash[:alert] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.username}.".html_safe
  end
end

private

	def find_post
		@user = User.find_by_username(params[:id])
	end
  
  
  
  

end
