class RemoveListNamesFromMadMimiEmails < ActiveRecord::Migration
  def up
    remove_column :mad_mimi_emails, :list_names
      end

  def down
    add_column :mad_mimi_emails, :list_names, :string
  end
end
