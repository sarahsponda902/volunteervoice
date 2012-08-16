class AddAdminReadToNewReviews < ActiveRecord::Migration
  def change
    add_column :new_reviews, :admin_read, :boolean, :default => false

  end
end
