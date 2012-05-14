class CreateFavorites < ActiveRecord::Migration
  def up
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :program_id
    end
  end
end
