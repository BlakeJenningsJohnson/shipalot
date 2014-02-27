class ShippingLogs < ActiveRecord::Migration
  def up
    create_table :shipping_logs do |t|
      t.text :request_dump
      t.text :response_dump

      t.timestamps
    end
  end

  def down
    drop_table :shippinglogs
  end
end
