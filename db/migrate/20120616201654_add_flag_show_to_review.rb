class AddFlagShowToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :flag_show, :boolean

  end
end
