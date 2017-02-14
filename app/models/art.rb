class Art < ActiveRecord::Base
	acts_as_votable
	#is_impressionable :counter_cache => true, :column_name => :counter_cache, :unique => :request_hash
	belongs_to :user
	has_many :commentarts
	acts_as_taggable_on :tags
	belongs_to :campaign
	has_many :ratings
	

	scope :by_tags, -> tags { where(:tags => tags) }
	scope :chosen, -> { where(:chosen => true) }
	

	has_attached_file :image, 
		:processors => [:watermark], 
		:url => "/system/:class/:attachment/:id_partition/:style/:filename",
  		:path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename",
		:styles => { 
			:large => {
					:geometry => "1200x1200#",
	                :watermark_path => Rails.root.join('app/assets/images/watermark.png'),
	                :position => 'SouthWest'
				}, 
			:medium => "500x500#", 
			:small => "300x300#"
			}, 
			:default_url => "/images/:style/missing.png"

  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/



end
