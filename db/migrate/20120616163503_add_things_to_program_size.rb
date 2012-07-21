class AddThingsToProgramSize < ActiveRecord::Migration
  def change
    add_column :program_sizes, :program_id, :integer

    add_column :program_sizes, :size, :string

  end
end
