class AddUrlToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :url, :string

  end
end
