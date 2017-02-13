class RenameDeliveryDateZoneOfOrdersToDeliveryDateSlot < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :delivery_time_zone, :delivery_time_slot
    change_column_default :orders, :delivery_time_slot, from: nil, to: 0
  end
end
