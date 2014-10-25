class Feeds < ActiveRecord::Base
  # Feed module is dependent on these table relationships
  has_many :feeds, through: :tags
  has_many :tags
  serialize :tag

end
