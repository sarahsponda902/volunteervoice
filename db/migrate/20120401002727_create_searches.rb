class CreateSearches < ActiveRecord::Migration
  def up
    create_table :searches do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def down
  end
end
