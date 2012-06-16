class AddThingsToProgramSubject < ActiveRecord::Migration
  def change
    add_column :program_subjects, :program_id, :integer

    add_column :program_subjects, :subject, :string

  end
end
