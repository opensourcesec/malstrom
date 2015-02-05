class AddDeepdiveToSamples < ActiveRecord::Migration
  def change
    add_column :samples, :deepdive, :text
  end
end
