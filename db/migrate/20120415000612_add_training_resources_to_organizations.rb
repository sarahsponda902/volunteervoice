class AddTrainingResourcesToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :training_resources, :text

  end
end
