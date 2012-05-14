class AddPageViewsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :page_views, :integer

  end
end
