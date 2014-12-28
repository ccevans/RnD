class Lyric < ActiveRecord::Base
	acts_as_votable
	is_impressionable
	belongs_to :user
	has_many :comments
	acts_as_taggable_on :tags
	
end
