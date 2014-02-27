class ShippingLogs < ActiveRecord::Migration
  def change
    create_table :shippinglogs do |t|
      t.text :request_dump
      t.text :response_dump

      t.timestamps
    end
  end
end
