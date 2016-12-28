class <%= migration_class_name %> < ActiveRecord::Migration
  def self.up
    add_column :audits, :agency_id, :integer
    add_column :audits, :agency_type, :string
    add_index :audits, [:agency_id, :agency_type], :name => 'agency_index'
  end

  def self.down
    if index_exists? :audits, [:agency_id, :agency_type], :name => 'agency_index'
      remove_index :audits, :name => 'agency_index'
    end
    remove_column :audits, :agency_id
    remove_column :audits, :agency_type
  end
end
