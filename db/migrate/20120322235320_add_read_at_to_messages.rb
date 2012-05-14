class AddReadAtToMessages < ActiveRecord::Migration
  def up
    add_column :messages, :read_at, :datetime
  end
end
