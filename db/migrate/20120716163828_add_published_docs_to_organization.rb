class AddPublishedDocsToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :published_docs, :boolean

  end
end
