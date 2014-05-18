class CreateJoinTableFeedsTag < ActiveRecord::Migration
  def change
    create_join_table :feeds, :tags do |t|
      # t.index [:feed_id, :tag_id]
      # t.index [:tag_id, :feed_id]
    end
  end
end
