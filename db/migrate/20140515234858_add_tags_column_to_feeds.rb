class AddTagsColumnToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :tags, :text
  end
end
