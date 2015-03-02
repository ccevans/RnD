class AddLegalToArt < ActiveRecord::Migration
  def change
    add_column :arts, :legal, :boolean
  end
end
