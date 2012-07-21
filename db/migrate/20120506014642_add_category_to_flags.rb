class AddCategoryToFlags < ActiveRecord::Migration
  def change
    add_column :flags, :category, :string

  end
end
