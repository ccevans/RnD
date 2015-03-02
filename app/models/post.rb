class Post < ActiveRecord::Base
	acts_as_votable
	is_impressionable :counter_cache => true, :column_name => :counter_cache, :unique => :request_hash
	belongs_to :user
	has_many :commentposts
	acts_as_taggable_on :tags

	scope :by_tags, -> tags { where(:tags => tags) }



	 TYPEOFS = %w[picture video audio]

	has_attached_file :image, :styles => { :large => "600x600#", :medium => "400x400#", :small => "200x200#" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  	has_attached_file :image1, :styles => { :large => "600x600#", :medium => "400x400#", :small => "200x200#" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image1, :content_type => /\Aimage\/.*\Z/

  	has_attached_file :image2, :styles => { :large => "600x600#", :medium => "400x400#", :small => "200x200#" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image2, :content_type => /\Aimage\/.*\Z/

  	has_attached_file :image3, :styles => { :large => "600x600#", :medium => "400x400#", :small => "200x200#" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image3, :content_type => /\Aimage\/.*\Z/
  	
end
