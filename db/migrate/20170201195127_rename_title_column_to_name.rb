class RenameTitleColumnToName < ActiveRecord::Migration[5.0]
  def change
    rename_column :products, :title, :name
  end
end
