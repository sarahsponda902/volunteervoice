class AddThingsToMadMimiEmails < ActiveRecord::Migration
  def change
    add_column :mad_mimi_emails, :username, :string

    add_column :mad_mimi_emails, :api_key, :string

    add_column :mad_mimi_emails, :bcc, :string

  end
end
