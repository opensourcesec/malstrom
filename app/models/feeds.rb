class Feeds < ActiveRecord::Base
  has_many :feeds, through: :tags
  has_many :tags

end
