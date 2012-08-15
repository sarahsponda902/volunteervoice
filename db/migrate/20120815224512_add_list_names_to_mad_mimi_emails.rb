class AddListNamesToMadMimiEmails < ActiveRecord::Migration
  def change
    add_column :mad_mimi_emails, :list_names, :text

  end
end
