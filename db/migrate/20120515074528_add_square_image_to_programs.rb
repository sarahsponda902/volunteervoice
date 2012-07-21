class AddSquareImageToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :square_image, :string

    add_column :programs, :crop_x, :integer

    add_column :programs, :crop_y, :integer

    add_column :programs, :crop_w, :integer

    add_column :programs, :crop_h, :integer

  end
end
