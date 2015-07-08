class CreateTraps < ActiveRecord::Migration
  def change
    create_table :traps, id: false do |t|
      t.string :name, primary_key: true

      t.timestamps null: false
    end
  end
end
