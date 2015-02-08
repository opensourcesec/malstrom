class AddNotesToSamples < ActiveRecord::Migration
  def change
    add_column :samples, :notes, :text
  end
end
