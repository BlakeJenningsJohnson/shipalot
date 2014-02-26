class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :response_dump
      t.integer :request_id

      t.timestamps
    end
  end
end
