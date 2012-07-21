class CreateMadMimiEmails < ActiveRecord::Migration
  def change
    create_table :mad_mimi_emails do |t|
      t.string :subject
      t.string :from
      t.string :promotion_name
      t.string :list_names
      t.timestamps
    end
  end
end
