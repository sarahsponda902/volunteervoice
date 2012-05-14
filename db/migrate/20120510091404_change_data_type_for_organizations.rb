class ChangeDataTypeForOrganizations < ActiveRecord::Migration
    def self.up
      change_table :organizations do |t|
        t.change :phone, :float
      end
    end

    def self.down
      change_table :organizations do |t|
        t.change :phone, :integer
      end
    end
  end
