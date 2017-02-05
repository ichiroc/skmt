class ChangeDefaultCartItemsQuantity < ActiveRecord::Migration[5.0]
  def change
    change_column_default :cart_items, :quantity, from: nil, to: 0
  end
end
