class CreateArts < ActiveRecord::Migration
  def change
    create_table :arts do |t|
      t.text :description
      t.string :artist
      t.string :type
      t.string :link

      t.timestamps
    end
  end
end
