class AddSourceToElement < ActiveRecord::Migration
  def change
    add_column :elements, :source, :string
  end
end
