class ChangeElementTypeToKind < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :kind, :string
    remove_column :elements, :type
  end
end
