class Video < ActiveRecord::Base
	belongs_to :user

	has_attached_file :image, :styles => { :large => "600x450#", :medium => "400x300#", :small => "200x150#" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  	scope :approve, -> { where(:approve => true) }
end
