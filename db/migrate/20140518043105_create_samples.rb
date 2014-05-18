class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :filename
      t.string :SHA256
      t.string :content_type
      t.text :description

      t.timestamps
    end
  end
end
