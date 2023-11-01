class ChangePhoneDataType < ActiveRecord::Migration[7.1]
  def change
    remove_column :patients, :phone, :integer
    add_column :patients, :phone, :string
  end
end
