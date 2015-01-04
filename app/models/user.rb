class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w[registered admin moderator editor banned]

  def role?(base_role)
        role.present? && ROLES.index(base_role.to_s) <= ROLES.index(role)
    end

  has_many :lyrics, dependent: :destroy
  has_many :adminlyrics     
  has_many :comments, dependent: :destroy  
  has_many :arts, dependent: :destroy
  has_many :commentarts, dependent: :destroy
  has_many :commentlyrics, dependent: :destroy
  has_many :campaigns
  has_many :ratings

  ratyrate_rater

  has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "50x50#", :mini => "20x20#"  }, :default_url => "/images/:style/black-logo-gasmask.png" 
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_attached_file :profileimg, :styles => { :large => "1200x400#", :medium => "300x100#"  }, :default_url => "/images/:style/profile-missing.png" 
  validates_attachment_content_type :profileimg, :content_type => /\Aimage\/.*\Z/

 acts_as_follower
 acts_as_followable
 
  
end
