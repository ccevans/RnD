class AddChosenToLyric < ActiveRecord::Migration
  def change
    add_column :lyrics, :chosen, :boolean
  end
end
