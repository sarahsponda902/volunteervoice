class AddCompanyNameToNewReviews < ActiveRecord::Migration
  def change
    add_column :new_reviews, :organization, :string

  end
end
