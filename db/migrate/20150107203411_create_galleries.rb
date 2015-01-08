class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
