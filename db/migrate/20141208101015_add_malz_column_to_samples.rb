class AddMalzColumnToSamples < ActiveRecord::Migration
  def self.up
    add_attachment :samples, :malz
  end

  def self.down
    remove_attachment :samples, :malz
  end
end