class RemoveBodyFromMessage < ActiveRecord::Migration
  def up
    remove_column :messages, :body
      end

  def down
    add_column :messages, :body, :string
  end
end
