class AddUrlColumnToFeeds < ActiveRecord::Migration[4.2]
  def change
    add_column :feeds, :url, :text
  end
end
