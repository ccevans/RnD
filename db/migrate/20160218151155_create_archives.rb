class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
