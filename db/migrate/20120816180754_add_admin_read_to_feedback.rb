class AddAdminReadToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :admin_read, :boolean, :default => false

  end
end
