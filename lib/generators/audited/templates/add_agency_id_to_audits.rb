class <%= migration_class_name %> < ActiveRecord::Migration
  def self.up
    add_column :audits, :agency_id, :integer
    add_index :audits, :agency_id
  end

  def self.down
    remove_column :audits, :agency_id
  end
end
