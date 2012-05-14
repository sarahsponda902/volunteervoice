class NewOnes < ActiveRecord::Migration
  def up
    add_column :messages, :recipient_deleted, :boolean, :default => false
  end
end