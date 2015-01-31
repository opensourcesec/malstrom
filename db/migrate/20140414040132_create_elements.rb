class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :value
      t.text :kind

      t.timestamps
    end
  end
end
