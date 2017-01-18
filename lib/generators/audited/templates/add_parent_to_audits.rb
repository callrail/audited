class <%= migration_class_name %> < ActiveRecord::Migration
  def self.up
    add_column :audits, :parent_id, :integer
    add_column :audits, :parent_type, :string
    add_index :audits, [:parent_id, :parent_type], :name => 'parent_index'
  end

  def self.down
    if index_exists? :audits, [:parent_id, :parent_type], :name => 'parent_index'
      remove_index :audits, :name => 'parent_index'
    end
    remove_column :audits, :parent_id
    remove_column :audits, :parent_type
  end
end
