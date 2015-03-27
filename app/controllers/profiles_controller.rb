class ProfilesController < ApplicationController
  before_action :all_photos, only: [:show]
  before_action :set_photos, only: [:destroy]
	before_action :find_post, only: [:show, :follow, :unfollow]
  has_scope :approve
  has_scope :featured

  respond_to :html, :json, :js

  def index
    @users = User.all.order("created_at DESC")
    @user = User.find_by_username(params[:id])
    @featured_users = User.featured.all.order("created_at DESC")


  end


  def show
    @approved_videos = Video.approve.where(user_id: @user)
    @videos = Video.where(user_id: @user)
    @video = Video.where(user_id: @user).first
  	@user = User.find_by_username(params[:id])
  	if @user
      
  		@lyrics = @user.lyrics.all.order("created_at DESC")
      @arts = @user.arts.all.order("created_at DESC")
      @posts = @user.posts.all.order("created_at DESC")
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

  def all_photos
        @user = User.find_by_username(params[:id])
        @photos = Photo.where(user_id: @user)
      end

      def set_photos
        @photo = Photo.find(params[:id])
      end
  
  
  
  

end
