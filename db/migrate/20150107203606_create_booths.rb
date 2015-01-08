class CreateBooths < ActiveRecord::Migration
  def change
    create_table :booths do |t|
      t.text :song
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
