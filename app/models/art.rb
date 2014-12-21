class Art < ActiveRecord::Base
	acts_as_votable
	belongs_to :user
	has_many :commentarts
	

	has_attached_file :image, :styles => { :medium => "500x500#", :small => "300x300#" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end