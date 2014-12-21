class RenameTypeColumnToTypeart < ActiveRecord::Migration
  def self.up
    rename_column :arts, :type, :typeart
  end

  def self.down
    rename_column :arts, :typeart, :type
  end
end
