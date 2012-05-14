class AddTheStuffToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :name, :string

    add_column :contacts, :email, :string

    add_column :contacts, :body, :text

    add_column :contacts, :to_whom, :string

    add_column :contacts, :subject, :string

  end
end
