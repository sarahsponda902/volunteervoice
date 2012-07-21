class ChangeReviewStarsToSplit < ActiveRecord::Migration
  def change
    change_column :reviews, :preparation, :decimal
    change_column :reviews, :support, :decimal
    change_column :reviews, :impact, :decimal
    change_column :reviews, :structure, :decimal

  end
end
