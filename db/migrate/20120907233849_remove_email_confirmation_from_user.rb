class RemoveEmailConfirmationFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :email_confirmation
      end

  def down
    add_column :users, :email_confirmation, :string
  end
end
