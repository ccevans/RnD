class Art < ActiveRecord::Base
	acts_as_votable
	is_impressionable
	belongs_to :user
	has_many :commentarts
	belongs_to :campaign
	acts_as_taggable_on :tags
	has_many :ratings
	ratyrate_rateable 'design'
	

	has_attached_file :image, :styles => { :medium => "500x500#", :small => "300x300#" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
