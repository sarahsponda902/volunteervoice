class CreateProgramSubjects < ActiveRecord::Migration
  def change
    create_table :program_subjects do |t|

      t.timestamps
    end
  end
end
