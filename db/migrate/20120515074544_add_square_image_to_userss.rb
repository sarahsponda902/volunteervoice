class AddSquareImageToUserss < ActiveRecord::Migration
  def change
    add_column :users, :square_image, :string
    
    remove_column :users, :square_photo_file_name
    
    remove_column :users, :square_photo_file_size
    
    remove_column :users, :square_photo_updated_at
    
    remove_column :users, :square_photo_content_size

  end
end
