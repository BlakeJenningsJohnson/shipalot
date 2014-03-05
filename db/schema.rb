
ActiveRecord::Schema.define(version: 20140227201812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shipping_logs", force: true do |t|
    t.text     "request_dump"
    t.text     "response_dump"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
