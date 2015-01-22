class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :filename
      t.string :sha256
      t.string :sha1sum
      t.string :md5sum

      t.timestamps
    end
  end
end
