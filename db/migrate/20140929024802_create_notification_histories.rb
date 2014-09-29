class CreateNotificationHistories < ActiveRecord::Migration
  def change
    create_table :notification_histories do |t|
      t.references :notification, index: true
      t.references :user, index: true
      t.string :title
      t.timestamps
    end
  end
end

