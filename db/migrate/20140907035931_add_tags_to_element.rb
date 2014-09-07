class AddTagsToElement < ActiveRecord::Migration
  def change
    add_column :elements, :tags, :string
  end
end
