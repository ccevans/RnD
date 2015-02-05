class AddChosenToArt < ActiveRecord::Migration
  def change
    add_column :arts, :chosen, :boolean
  end
end
