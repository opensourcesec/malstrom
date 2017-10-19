class AddAttachmentMalzToSamples < ActiveRecord::Migration[4.2]
  def self.up
    change_table :samples do |t|
      t.attachment :malz
    end
  end

  def self.down
    remove_attachment :samples, :malz
  end
end
