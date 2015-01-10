class Post < ActiveRecord::Base
	acts_as_votable
	is_impressionable
	belongs_to :user
	has_many :commentposts

	 TYPEOFS = %w[video audio picture]

	has_attached_file :image, :styles => { :large => "600x600#", :medium => "400x400#", :small => "200x200#" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  	
end
