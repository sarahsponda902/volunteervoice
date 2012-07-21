class AddStuffToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :organization_id, :integer

    add_column :reviews, :time_frame, :integer

    add_column :reviews, :before, :boolean

    add_column :reviews, :terms, :boolean

    add_column :reviews, :preparation, :integer

    add_column :reviews, :support, :integer

    add_column :reviews, :impact, :integer

    add_column :reviews, :structure, :integer

    add_column :reviews, :overall, :integer

  end
end
