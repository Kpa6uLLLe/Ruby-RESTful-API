class CreateRecommendations < ActiveRecord::Migration[7.1]
  def change
    create_table :recommendations do |t|
      t.text :responseBody
      t.belongs_to :request
      t.timestamps
    end
  end
end
