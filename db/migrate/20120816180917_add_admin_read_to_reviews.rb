class AddAdminReadToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :admin_read, :boolean, :default => false

  end
end
