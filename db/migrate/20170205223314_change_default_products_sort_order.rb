class ChangeDefaultProductsSortOrder < ActiveRecord::Migration[5.0]
  def change
    change_column_default :products, :sort_order, from: nil, to: 100
  end
end
