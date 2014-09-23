class ChangeColumnStartAtAndEndAtToNotifications < ActiveRecord::Migration
  def change
    change_column :notifications, :start_at, :time
    change_column :notifications, :end_at, :time
  end
end
