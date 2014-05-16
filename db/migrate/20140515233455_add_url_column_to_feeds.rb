class AddUrlColumnToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :url, :text
  end
end
