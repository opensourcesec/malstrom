class AddDetectionToSamples < ActiveRecord::Migration[4.2]
  def change
    add_column :samples, :detection, :text
  end
end
