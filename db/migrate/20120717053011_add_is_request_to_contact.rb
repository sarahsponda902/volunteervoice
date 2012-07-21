class AddIsRequestToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :is_request, :boolean

  end
end
