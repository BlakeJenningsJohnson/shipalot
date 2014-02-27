class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :request_dump
      t.integer :response_id
      
      t.timestamps
    end
  end
end
