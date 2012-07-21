class ChangeColumnTypeOverall < ActiveRecord::Migration
  def change
    change_column :organizations, :overall, :decimal
    
    change_column :programs, :overall, :decimal
    
    change_column :reviews, :overall, :decimal
  end
end
