class Art < ActiveRecord::Base
	acts_as_votable
	is_impressionable :counter_cache => true, :column_name => :counter_cache, :unique => :request_hash
	belongs_to :user
	has_many :commentarts
	acts_as_taggable_on :tags
	belongs_to :campaign
	has_many :ratings
	

	scope :by_tags, -> tags { where(:tags => tags) }
	

	has_attached_file :image, :styles => { :medium => "500x500#", :small => "300x300#" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
