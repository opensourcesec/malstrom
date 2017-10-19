class AddDeepdiveToSamples < ActiveRecord::Migration[4.2]
  def change
    add_column :samples, :deepdive, :text
  end
end
