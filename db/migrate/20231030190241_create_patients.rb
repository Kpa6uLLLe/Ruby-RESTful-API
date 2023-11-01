class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :initials
      t.date :birthdate
      t.integer :phone
      t.string :email

      t.timestamps
    end
  end
end
