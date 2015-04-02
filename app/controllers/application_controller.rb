class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token


  before_action :configure_permitted_parameters, if: :devise_controller?
  

  def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :username, :email, :password, :role) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :username, :email, :password, :current_password, :avatar, :role, :profileimg, :website, :location, :bio, :passion, :featured, {booths_attributes: [:id, :song, :_destroy]}, {galleries_attributes: [:id, :picture, :_destroy]}) }
    end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end 


end
