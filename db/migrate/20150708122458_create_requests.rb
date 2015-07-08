class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :trap_id, null: false, index: true
      t.string :remote_ip
      t.string :request_method
      t.string :scheme
      t.string :query_string
      t.jsonb :query_params
      t.jsonb :cookies
      t.jsonb :headers
      t.text :raw

      t.timestamps null: false
    end

    add_foreign_key :requests, :traps
  end
end
