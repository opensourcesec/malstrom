class AddSourceToElement < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :source, :string
  end
end
