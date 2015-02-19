class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :videolink
      t.boolean :approve

      t.timestamps
    end
  end
end
