class CreateElements < ActiveRecord::Migration[4.2]
  def change
    create_table :elements do |t|
      t.string :value
      t.text :type

      t.timestamps
    end
  end
end
