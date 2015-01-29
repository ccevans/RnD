class Lyric < ActiveRecord::Base
	acts_as_votable
	is_impressionable :counter_cache => true, :column_name => :counter_cache, :unique => :request_hash
	belongs_to :user
	has_many :comments
	acts_as_taggable_on :tags
	belongs_to :campaign

	 scope :by_tags, -> tags { where(:tags => tags) }
	 scope :by_campaign, -> campaign_id { where("camapign_id = ?", :campaign_id) }
	 scope :most_liked, order(:cached_votes_up => :desc)
	 scope :most_recent, order("created_at desc")
	
end
