class Lyric < ActiveRecord::Base
	acts_as_votable
	is_impressionable
	belongs_to :user
	has_many :comments
	acts_as_taggable_on :tags
	belongs_to :campaign

	 scope :by_tags, -> tags { where(:tags => tags) }
	
end
