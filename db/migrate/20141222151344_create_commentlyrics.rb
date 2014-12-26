class CreateCommentlyrics < ActiveRecord::Migration
  def change
    create_table :commentlyrics do |t|
      t.text :content
      t.references :adminlyric, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
