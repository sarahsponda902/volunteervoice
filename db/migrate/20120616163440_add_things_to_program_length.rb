class AddThingsToProgramLength < ActiveRecord::Migration
  def change
    add_column :program_lengths, :program_id, :integer

    add_column :program_lengths, :length, :string

  end
end
