class RenameZipcodeToZipCode < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :zipcode, :zip_code
  end
end
