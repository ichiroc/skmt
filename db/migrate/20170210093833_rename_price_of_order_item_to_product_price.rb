class RenamePriceOfOrderItemToProductPrice < ActiveRecord::Migration[5.0]
  def change
    rename_column :order_items, :price, :product_price
  end
end
