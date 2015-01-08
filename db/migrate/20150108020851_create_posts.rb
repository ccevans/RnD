class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :link
      t.text :description
      t.string :typeof
      t.boolean :approve

      t.timestamps
    end
  end
end
