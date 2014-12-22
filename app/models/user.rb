class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w[registered admin moderator editor banned]

 def role?(base_role)
        role.present? && ROLES.index(base_role.to_s) <= ROLES.index(role)
    end

  has_many :lyrics
  has_many :adminlyrics     
  has_many :comments  
  has_many :arts
  has_many :commentarts

  has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "50x50#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

 
  
end
