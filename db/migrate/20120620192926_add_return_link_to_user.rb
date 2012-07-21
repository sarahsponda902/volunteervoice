class AddReturnLinkToUser < ActiveRecord::Migration
  def change
    add_column :users, :return_link, :string

  end
end
