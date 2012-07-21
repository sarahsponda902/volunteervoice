class AddAgeAndCountryToUsers < ActiveRecord::Migration
  def up
    add_column :users, :age, :integer
    add_column :users, :country, :string
  end
end
