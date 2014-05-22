class ChangeElementColumnNames < ActiveRecord::Migration
  def change
    rename_column :Elements, :type, :kind
  end
end
