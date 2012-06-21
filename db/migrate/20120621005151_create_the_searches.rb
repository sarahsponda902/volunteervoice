class CreateTheSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.text :regions
      t.text :subjects
      t.text :lengths
      t.text :sizes
      t.integer :price_min
      t.integer :price_max

      t.timestamps
    end
  end
end

