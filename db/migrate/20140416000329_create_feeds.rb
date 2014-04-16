class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.text :last_updated
      t.text :next_run

      t.timestamps
    end
  end
end
