class AddAttachmentMalzToSamples < ActiveRecord::Migration
  def self.up
    change_table :samples do |t|
      t.attachment :malz
    end
  end

  def self.down
    remove_attachment :samples, :malz
  end
end
