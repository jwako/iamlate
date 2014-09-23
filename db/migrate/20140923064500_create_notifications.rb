class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :email
      t.integer :railway, index: true
      t.string :token, unique: true
      t.boolean :active, default: false, null: false
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
