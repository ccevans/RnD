class AddAudiolinkToPost < ActiveRecord::Migration
  def change
    add_column :posts, :audiolink, :text
  end
end
