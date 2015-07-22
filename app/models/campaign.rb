class Campaign < ActiveRecord::Base
	belongs_to :user
	has_many :lyrics, dependent: :destroy
	has_many :arts, dependent: :destroy

	scope :by_status, -> status { where(:status => status) }
	scope :free, -> { where(:status => "free") }
	scope :open, -> { where(:status => "open") }
	scope :closed, -> { where(:status => "closed") }
	scope :draft, -> { where(:status => "draft") }

	STATUS = %w[draft free open closed hide]


	has_attached_file :image, :styles => { :large => "1200x300#", :medium => "800x200#", :thumb => "80x20#"  }, :default_url => "/images/:style/profile-missing.png"  
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
