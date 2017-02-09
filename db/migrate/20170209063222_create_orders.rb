class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :total
      t.integer :tax_amount
      t.integer :delivery_charge
      t.integer :cache_on_delivery_fee
      t.integer :delivery_time
      t.date :delivery_date
      t.string :destination_name
      t.string :destination_zip_code
      t.string :destination_address

      t.timestamps
    end
  end
end
