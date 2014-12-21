class CreateCommentarts < ActiveRecord::Migration
  def change
    create_table :commentarts do |t|
      t.text :content
      t.references :art, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
