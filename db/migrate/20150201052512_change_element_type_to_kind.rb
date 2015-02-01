class ChangeElementTypeToKind < ActiveRecord::Migration
  def change
    add_column :elements, :kind, :string
    remove_column :elements, :type
  end
end
