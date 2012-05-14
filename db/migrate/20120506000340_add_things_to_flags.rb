class AddThingsToFlags < ActiveRecord::Migration
  def change
    add_column :flags, :body, :text

    add_column :flags, :poster_id, :integer

    add_column :flags, :flagger_id, :integer

  end
end
