class AddPersonalToLyric < ActiveRecord::Migration
  def change
    add_column :lyrics, :personal, :boolean
  end
end
