class Campaign < ActiveRecord::Base
	belongs_to :user
	has_many :lyrics
	has_many :arts

	scope :by_status, -> status { where(:status => status) }
	scope :free, -> { where(:status => "free") }
	scope :open, -> { where(:status => "open") }
	scope :closed, -> { where(:status => "closed") }
	

	STATUS = %w[free open closed]


	has_attached_file :image, :styles => { :large => "1200x300#", :medium => "800x200#", :thumb => "80x20#"  }, :default_url => "/images/:style/profile-missing.png"  
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
