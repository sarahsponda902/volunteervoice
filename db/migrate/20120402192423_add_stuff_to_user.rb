class AddStuffToUser < ActiveRecord::Migration
  def change
    add_column :users, :validate_user_email, :string

    add_column :users, :validate_user_name, :string

  end
end
