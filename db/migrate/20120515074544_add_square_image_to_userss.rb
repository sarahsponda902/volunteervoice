class AddSquareImageToUserss < ActiveRecord::Migration
  def change
    add_column :users, :square_image, :string

  end
end
