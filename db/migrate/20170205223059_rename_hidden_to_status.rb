class RenameHiddenToStatus < ActiveRecord::Migration[5.0]
  def change
    rename_column :products, :hidden, :status
    change_column_default :products, :status, from: nil, to: 0
  end
end
