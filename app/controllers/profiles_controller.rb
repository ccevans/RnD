class ProfilesController < ApplicationController
  before_action :all_photos, only: [:show]
  before_action :set_photos, only: [:destroy]
	before_action :find_post, only: [:show, :follow, :unfollow]
  has_scope :approve
  has_scope :featured
  before_action :add_points, only: [:dash, :index, :show]
  before_action :authenticate_user!, only: [:dash]
  

  respond_to :html, :json, :js

  def index
    @users = User.all.order("created_at DESC")
    @user = User.find_by_username(params[:id])
    @featured_users = User.featured.all.order("created_at DESC")


  end


  def show
    @approved_videos = Video.approve.where(user_id: @user)
    @approved_video = Video.approve.where(user_id: @user).last
    @videos = Video.where(user_id: @user)
    @video = Video.where(user_id: @user).last
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

  def dash
    @approved_posts = Post.approved.where(user_id: @current_user)

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


def add_points


    if user_signed_in?
    @profile_points = (@current_user.points(category: 'profile') + @current_user.points(category: 'avatar') + @current_user.points(category: 'profileimg') + @current_user.points(category: 'bio') + @current_user.points(category: 'passion') + @current_user.points(category: 'website') + @current_user.points(category: 'location'))


    if @current_user.avatar.present?
    @count = @current_user.points(category: 'avatar')

      
        while @count < 1 
          @current_user.add_points(10, category: 'avatar')
          @count = @current_user.points(category: 'avatar')
        end
      end

      if @current_user.profileimg.present?
      @count1 = @current_user.points(category: 'profileimg')

      
        while @count1 < 1 
          @current_user.add_points(10, category: 'profileimg')
          @count1 = @current_user.points(category: 'profileimg')
        end
      end

      if @current_user.bio.present?
      @count2 = @current_user.points(category: 'bio')

        while @count2 < 1 
          @current_user.add_points(10, category: 'bio')
          @count2 = @current_user.points(category: 'bio')
        end
      end

      if @current_user.passion.present?
      @count3 = @current_user.points(category: 'passion')

        while @count3 < 1 
          @current_user.add_points(10, category: 'passion')
          @count3 = @current_user.points(category: 'passion')
        end
      end

      if @current_user.location.present?
      @count4 = @current_user.points(category: 'location')

        while @count4 < 1 
          @current_user.add_points(5, category: 'location')
          @count4 = @current_user.points(category: 'location')
        end
      end

      if @current_user.website.present?
      @count5 = @current_user.points(category: 'website')

        while @count5 < 1 
          @current_user.add_points(5, category: 'website')
          @count5 = @current_user.points(category: 'website')
        end
      end
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
