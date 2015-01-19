class AddDetectionToSamples < ActiveRecord::Migration
  def change
    add_column :samples, :detection, :text
  end
end
