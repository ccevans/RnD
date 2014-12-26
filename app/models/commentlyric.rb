class Commentlyric < ActiveRecord::Base
  belongs_to :adminlyric
  belongs_to :user
end
