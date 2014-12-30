class Campaign < ActiveRecord::Base
	belongs_to :user

	has_attached_file :image, :styles => { :large => "400x400#", :medium => "150x150#", :thumb => "50x50#"  }, :default_url => "/images/:style/missing-campaign.png" 
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
