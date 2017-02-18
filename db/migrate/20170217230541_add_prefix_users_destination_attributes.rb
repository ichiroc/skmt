class AddPrefixUsersDestinationAttributes < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :name, :destination_name
    rename_column :users, :zip_code, :destination_zip_code
    rename_column :users, :address, :destination_address
  end
end
