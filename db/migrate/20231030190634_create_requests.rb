class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.text :requestBody
      t.date :creationDate
      t.belongs_to :patient
      t.timestamps
    end
  end
end
