class AddPublishedDocsToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :published_docs, :boolean

  end
end
