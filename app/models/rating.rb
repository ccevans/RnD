class Rating < ActiveRecord::Base
  belongs_to :art
  belongs_to :user

  validates_uniqueness_of :user_id, scope: [:art_id]

end
