class AddSquareImageToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :square_image, :string

    add_column :organizations, :crop_x, :integer

    add_column :organizations, :crop_y, :integer

    add_column :organizations, :crop_w, :integer

    add_column :organizations, :crop_h, :integer

  end
end
